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
    var handler: PduHandler?
    let appKey = "E8eA0fEc0B3a8af1ca39b0aBADc0F18d"
    let url : String = "wss://kpbbao2l.api.satori.com"
    let channelName = "test-feed"

    func initialize() {
        setupSatori()
    }
    
    func setupSatori() {
        //: __Define the PduHandler. This will be called by Satori rtm when there is activity for the subscribe success/error response and subscription data responses.__
        handler = {(SatoriPdu) -> Void in
            let action : rtm_action_t = SatoriPdu.action;
            switch action {
            case RTM_ACTION_SUBSCRIPTION_DATA:
                let body : NSDictionary = SatoriPdu.body as NSDictionary;
                // Broadcast the subscribed data for app
                DispatchQueue.main.async {
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: Constants.NotificationKey.Satori),
                                                    object: nil, userInfo: body as? [AnyHashable : Any])
                }
            default:
                break
            }
        }
        //: __Connect to Satori using SatoriRtmConnection. And subscribe to channel to show title and published on date in real time__
        DispatchQueue.global(qos: .background).async {
            self.conn = SatoriRtmConnection(url: self.url, andAppkey: self.appKey);
            self.conn?.connect(pduHandler: self.handler!)
            var requestId:UInt32 = 123;
            self.conn?.subscribe(self.channelName, andRequestId: &requestId);
            while ((self.conn?.poll().rawValue)! >= 0) {
                sleep(1);
            }
        }
    }
    
    func jsonToString(json: AnyObject) -> String {
        do {
            let data =  try JSONSerialization.data(withJSONObject: json, options: JSONSerialization.WritingOptions.prettyPrinted)
            return String(data: data, encoding: String.Encoding.utf8)!
        } catch let myJSONError {
            print(myJSONError)
        }
        return ""
    }

    func publish(quest: Quest) {
        DispatchQueue.global(qos: .background).async {
            self.conn?.connect(pduHandler: self.handler!)
            var id:UInt32 = 123
            let bytesPointer = UnsafeMutablePointer<UInt32>(&id)

            let jsonObject = [
                [
                "usedId": quest.creator.id,
                "lat": quest.lat,
                "lng": quest.lng,
                "direction": "offer",
                "type": quest.category.rawValue
                ]
            ]

            self.conn?.publishString(self.jsonToString(json: jsonObject as AnyObject),
                                     toChannel: self.channelName, andRequestId: bytesPointer)
        }

    }
}
