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
    
    class func getNumberOfSections () -> Int
    {
        return accountItems.count
    }
    
    class func getNumberOfCells (atSection section: Int) -> Int
    {
        let section = accountItems[section] as! ACWallPost
        return section.content.count
    }
    
    class func getCellModel (atIndex index: Int) -> ACWallPost
    {
        return accountItems[index] as! ACWallPost
    }    
}

//MARK: загрузка с божьей помощью данных из греховного интернета для богомерзкой шапки профиля
extension ACAccountManager
{
    
    
    
    class func getAccountItems (success: @escaping () -> Void, failure: @escaping (_ errorCode: Int) -> Void) -> Void
    {
        
        if accountItems.count == 0
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
            
            counters.setObject(fullCounters["friends"]!.stringValue, forKey: NSString(string: "friends"))
            counters.setObject(fullCounters["subscriptions"]!.stringValue, forKey: NSString(string: "subs"))
            counters.setObject(fullCounters["groups"]!.stringValue, forKey: NSString(string: "groups"))
            counters.setObject(fullCounters["photos"]!.stringValue, forKey: NSString(string: "photos"))
            
            
            API_WRAPPER.getWall(successBlock: { (jsonResponse) in
                
                let response = jsonResponse["response"]
                
                let wallPosts = response["wall"].arrayValue
                let profilesArray = response["profiles"].arrayValue
                let groupsArray = response["groups"].arrayValue
                
                let sourceDictionary = NSMutableDictionary()
                
                for profile in profilesArray
                {
                    sourceDictionary.setObject(profile, forKey: NSString(string: "\(profile["uid"].int64Value)"))
                }
                
                for group in groupsArray
                {
                    sourceDictionary.setObject(group, forKey: NSString(string: "-\(group["gid"].int64Value)"))
                }
                
                var content = [ACBaseItem]()
                
                for i in 1..<wallPosts.count
                {
                    let post = wallPosts[i]
                    let postId = post["id"].stringValue
                    let postType = post["post_type"].stringValue
                    let sourceId = post["from_id"].int64Value
                    if let sourceJSON = sourceDictionary["\(sourceId)"] as? JSON
                    {
                    //если пост - добавляем пост хедер (пока screen_name)
                    if postType == "post"
                    {
                        let sourceName = sourceJSON["screen_name"].stringValue
                        let sourceImage = sourceJSON["photo"]
                            .stringValue
                        
                        let source = ACCellSource(WithSourceID: sourceId, sourceName: sourceName, sourceImage: sourceImage)
                        let postHeader = ACCellHeader(cellId: 42, source: source)
                        content.append(postHeader)
                    }
                    
                    //если пост - перепост
                    if postType == "copy"
                    {
                        let sourceName = sourceJSON["screen_name"].stringValue
                        let sourceImage = sourceJSON["photo"]
                            .stringValue
                        
                        let copySourceId = post["copy_owner_id"].int64Value
                        
                        let copySourceJSON = sourceDictionary["\(copySourceId)"] as! JSON
                        
                        let copySourceName = copySourceJSON["name"].stringValue
                        let copySourceImage = copySourceJSON["photo_100"].stringValue
                        
                        let source = ACCellSource(WithSourceID: sourceId, sourceName: sourceName, sourceImage: sourceImage)
                        
                        let copySource = ACCellSource(WithSourceID: copySourceId, sourceName: copySourceName, sourceImage: copySourceImage)
                        
                        let postHeader = ACCellHeader(cellId: 42, source: source)
                        let postCopySource = ACWallPostCopyHeader(cellId: 43, copySource: copySource)
                        
                        content.append(postHeader)
                        content.append(postCopySource)
                    }
                    }
                    let postText = post["text"].stringValue
                    if postText != ""
                    {
                        let text = ACCellText(WithCellID: 44, text: postText)
                        content.append(text)
                    }
                    
                    let postAttachment = post["attachment"].dictionaryValue
                    let postImages = postAttachment["photo"]?.dictionaryValue
                    let postImage = postImages?["src_big"]?.stringValue
                    
                    if postImages != nil
                    {
                        let image = ACCellImage(WithCellID: 45, imageURL: postImage!)
                        content.append(image)
                    }
                    
                    let postLikes = post["likes"].dictionaryValue
                    let postLikesCount = postLikes["count"]!.int64Value
                    let footer = ACCellFooter(WithCellID: 46, newsLikesCount: postLikesCount)
                    
                    content.append(footer)
                    print("количество в секции - \(content.count)")
                
                    let localWallPost = ACWallPost(postId: postId, content: content)
                    accountItems.append(localWallPost)
                    
                    content.removeAll()
                }
                
                var cityName = " "
                
                API_WRAPPER.getCityTitle(forCityId: cityId, successBlock: { (jsonResponse) in
                    
                    let response = jsonResponse["response"].arrayValue
                    let cityDict = response[0].dictionaryValue
                    cityName = cityDict["name"]!.stringValue
                    let accountInfo = ACAccount(cellId: 41, uId: uId, firstName: firstName, lastName: lastName, bDate: bDate, cityName: cityName, avatarURL: avatarURL, counters: counters)
                    
                    var tempArrayForAccountInfo = [ACBaseItem]()
                    tempArrayForAccountInfo.append(accountInfo)
                    
                    let account = ACWallPost(postId: "info", content: tempArrayForAccountInfo)
                    
                    accountItems.insert(account, at: 0)
                    
                    success()
                    
                }, failureBlock: failure)
        
            }, failureBlock: failure)
            
        }, failureBlock: failure)
        }
    }
}
