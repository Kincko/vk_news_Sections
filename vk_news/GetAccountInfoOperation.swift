//
//  GetAccountInfoOperation.swift
//  vk_news
//
//  Created by Gregory House on 02.01.17.
//  Copyright © 2017 vvz. All rights reserved.
//

import Foundation

class GetAccountInfoOperation: Operation
{
    var success: (NSArray) -> Void
    var failure: (Int) -> Void
    
    var internetTask: URLSessionDataTask?
    
    init(success: @escaping (NSArray) -> Void, failure: @escaping (Int) -> Void)
    {
        self.success = success
        self.failure = failure
    }
    
    override func cancel()
    {
        internetTask?.cancel()
    }
    
    override func main()
    {
        let semaphore = DispatchSemaphore(value: 0)
        
        internetTask = API_WRAPPER.getAccountInfo(successBlock: { (jsonResponse) in
            
            
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
            
            counters.setObject(fullCounters["friends"]!.stringValue, forKey: NSString(string: "friends"))
            counters.setObject(fullCounters["subscriptions"]!.stringValue, forKey: NSString(string: "subs"))
            counters.setObject(fullCounters["groups"]!.stringValue, forKey: NSString(string: "groups"))
            counters.setObject(fullCounters["photos"]!.stringValue, forKey: NSString(string: "photos"))
            
            let accountInfo = ACAccount(cellId: 41, uId: uId, firstName: firstName, lastName: lastName, bDate: bDate, cityName: String(cityId), avatarURL: avatarURL, counters: counters)
            
            var tempArrayForAccountInfo = [ACBaseItem]()
            tempArrayForAccountInfo.append(accountInfo)
            
            let account = ACWallPost(postId: "info", content: tempArrayForAccountInfo)

            var accountItems = [ACBaseItem]()
            
            accountItems.insert(account, at: 0)

            if (self.isCancelled)
            {
                self.success(NSArray())
            }
            else
            {
                self.success(accountItems as NSArray) //конечный массив из парсинга передается тут
            }
            
            semaphore.signal()
            
        }, failureBlock: { (errorCode) in
            
            self.failure(errorCode)
            semaphore.signal()
            
        })
        
        _ = semaphore.wait(timeout: DispatchTime.distantFuture)
        
    
    }
}
