//
//  ACAccount.swift
//  vk_news
//
//  Created by Gregory House on 24.11.16.
//  Copyright © 2016 vvz. All rights reserved.
//

import Foundation

class ACAccount: ACBaseItem
{
    var cellId: Int64
    var uId: Int64
    var firstName: String
    var lastName: String
    var bDate: String
    var cityName: String
    var avatarURL: String
    var counters: NSMutableDictionary
    init(cellId: Int64, uId: Int64, firstName: String, lastName: String, bDate: String, cityName: String, avatarURL: String, counters: NSMutableDictionary)
    {
        self.cellId = cellId
        self.uId = uId
        self.firstName = firstName
        self.lastName = lastName
        self.bDate = bDate
        self.cityName = cityName
        self.avatarURL = avatarURL
        self.counters = counters
        
    }
}
