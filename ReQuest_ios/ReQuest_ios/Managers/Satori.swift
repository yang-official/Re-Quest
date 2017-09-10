//
//  Satori.swift
//  ReQuest_ios
//
//  Created by Leon Mak on 10/9/17.
//  Copyright © 2017 Leon Mak. All rights reserved.
//

import Foundation
import SatoriRtmSdkWrapper

public class Satori {
    // Singleton for Satori
    static let instance = Satori()
    public var conn: SatoriRtmConnection? = nil

    func initialize() {
        setupSatori()
    }
    
    func setupSatori() {
        let appKey = "B4C5b11aA7BAca204ED5e6B3BE6f2252"
        let url : String = "wss://open-data.api.satori.com"
        let channelName = "big-rss"
        //: __Define the PduHandler. This will be called by Satori rtm when there is activity for the subscribe success/error response and subscription data responses.__
        let handler : PduHandler = {(SatoriPdu) -> Void in
            let action : rtm_action_t = SatoriPdu.action;
            switch action {
            case RTM_ACTION_SUBSCRIPTION_DATA:
                let body : NSDictionary = SatoriPdu.body as NSDictionary;
                let arr = body.object(forKey: "messages") as! NSArray;
                let msg : NSDictionary = arr.object(at: 0) as! NSDictionary;
                let title = (msg.object(forKey: "title") as! String);
                let publishedTs = (msg.object(forKey: "publishedTimestamp") as! String);
                // Broadcast the subscribed data for app
                DispatchQueue.main.async {
                    print("BROADCASTING: ", msg, title, publishedTs)
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: Constants.NotificationKey.Satori),
                                                    object: nil, userInfo: SatoriPdu.body)
                }
            default:
                break
            }
        }
        //: __Connect to Satori using SatoriRtmConnection. And subscribe to channel to show title and published on date in real time__
        DispatchQueue.global(qos: .background).async {
            self.conn = SatoriRtmConnection(url: url, andAppkey: appKey);
            self.conn?.connect(pduHandler: handler)
            var requestId:UInt32 = 123; // TODO: generate random?
            self.conn?.subscribe(channelName, andRequestId: &requestId);
            while ((self.conn?.poll().rawValue)! >= 0) {
                sleep(1);
            }
        }
    }
}
