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
        let appKey = "E8eA0fEc0B3a8af1ca39b0aBADc0F18d"
        let url : String = "wss://kpbbao2l.api.satori.com"
        let channelName = "test-feed"
        //: __Define the PduHandler. This will be called by Satori rtm when there is activity for the subscribe success/error response and subscription data responses.__
        let handler : PduHandler = {(SatoriPdu) -> Void in
            let action : rtm_action_t = SatoriPdu.action;
            switch action {
            case RTM_ACTION_SUBSCRIPTION_DATA:
                let body : NSDictionary = SatoriPdu.body as NSDictionary;
                // Broadcast the subscribed data for app
                DispatchQueue.main.async {
                    print("BROADCASTING: ", body)
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
