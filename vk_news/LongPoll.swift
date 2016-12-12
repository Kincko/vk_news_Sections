//
//  LongPoll.swift
//  vk_news
//
//  Created by Admin on 09.12.16.
//  Copyright © 2016 vvz. All rights reserved.
//

import Foundation


class LongPoll
{
    static var server = ""
    static var key = ""
    static var ts = ""
    
    class func getLongPoll()
    {
        if ts == ""
        {
        ACDialogManager.getLongPoll(success: {
            DispatchQueue.main.async
                {
                    print("success")
                    getRequest(key: self.key, server: self.server, ts: self.ts)
            }
        }) { (errorCode) in
            
        }
        }
        else
        {
            getRequest(key: self.key, server: self.server, ts: self.ts)
        }
    }
    
    class func getRequest(key:String, server:String, ts:String)
    {
        ACDialogManager.getRequest(withKey: key, withServer: server, withTs: ts, success: {
            DispatchQueue.main.async
                {
                    print("success2")
                    
            }
        }) { (errorCode) in
            
        }
    }
}
