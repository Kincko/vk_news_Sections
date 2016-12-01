//
//  Consts.swift
//  vk_news
//
//  Created by Gregory House on 02.11.16.
//  Copyright © 2016 vvz. All rights reserved.
//

import Foundation

class Const
{
    class URLConst
    {
        static let kBaseURL = "https://api.vk.com/method/"
        
        class Scripts
        {
            static let kMethod = "newsfeed.get"
            static let kMethodMessage = "messages.getDialogs"
            static let kMethodUser = "users.get"
            static let kMethodUserChat = "messages.getHistory"
        }
        
        class Arguments
        {
            static let kFilters : NSString = "filters"
            static let kCount : NSString = "count"
            static let kUser : NSString = "user_ids"
            static let kFields : NSString = "fields"
            static let kAccessToken: NSString = "access_token"
            static let kUserChat : NSString = "user_id"
        }
    }
    
    class AccessToken
    {
       static var accessToken: NSString = ""
    }
}
