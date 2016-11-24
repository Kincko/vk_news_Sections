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
            static let kMethodForAccountInfo = "users.get"
            static let kMethodForWall = "wall.get"
            static let kMethodForCity = "database.getCitiesById"
        }
        
        class Arguments
        {
            static let kFilters : NSString = "filters"
            static let kCount : NSString = "count"
            static let kFields: NSString = "fields"
            static let kExtended: NSString = "extended"
            static let kCityId: NSString = "city_ids"
            static let kAccessToken: NSString = "access_token"
        }
    }
}
