//
//  ACAccountManager.swift
//  vk_news
//
//  Created by Gregory House on 24.11.16.
//  Copyright © 2016 vvz. All rights reserved.
//

import Foundation

class ACAccountManager
{
    static var accountItems = [ACBaseItem]()
    
    class func getNumberOfCells () -> Int
    {
        return accountItems.count
    }
    
    class func getCellModel (atIndex index: Int) -> ACAccount
    {
        return accountItems[index] as! ACAccount
    }

    
}

//MARK: загрузка с божьей помощью данных из греховного интернета для богомерзкой шапки профиля
extension ACAccountManager
{

    class func getAccountItems (success: @escaping () -> Void, failure: @escaping (_ errorCode: Int) -> Void) -> Void
    {
        API_WRAPPER.getAccountInfo(successBlock: { (jsonResponse) in
            
            let rawresponse = jsonResponse["response"].arrayValue
            
            let response = rawresponse[0]
            
            let uId = response["uid"].int64Value
            let firstName = response["first_name"].stringValue
            let lastName = response["last_name"].stringValue
            let bDate = response["bdate"].stringValue
            let cityId = response["city"].int64Value
            let avatarURL = response["photo_100"].stringValue
            let fullCounters = response["counters"].dictionaryValue
        
            let counters = NSMutableDictionary()
            
            counters.setObject(fullCounters["friends"]!, forKey: NSString(string: "friends"))
            counters.setObject(fullCounters["subscriptions"]!, forKey: NSString(string: "subs"))
            counters.setObject(fullCounters["groups"]!, forKey: NSString(string: "groups"))
            counters.setObject(fullCounters["photos"]!, forKey: NSString(string: "photos"))
            
            var cityName = String()
            
            API_WRAPPER.getCityTitle(forCityId: cityId, successBlock: { (jsonResponse) in
                
                let response = jsonResponse["response"].arrayValue
                let cityDict = response[0].dictionaryValue
                cityName = cityDict["name"]!.stringValue
                
            }, failureBlock: failure)
            
            let localItem = ACAccount(cellId: 41, uId: uId, firstName: firstName, lastName: lastName, bDate: bDate, cityName: cityName, avatarURL: avatarURL, counters: counters)
            
            accountItems.append(localItem)
            
        }, failureBlock: failure)
    }

}
