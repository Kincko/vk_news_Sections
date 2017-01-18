//
//  GetWallOperation.swift
//  vk_news
//
//  Created by Gregory House on 12.01.17.
//  Copyright © 2017 vvz. All rights reserved.
//

import Foundation

class GetWallOperation: Operation
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
        
        internetTask = API_WRAPPER.getWall(successBlock: { (jsonResponse) in
            
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
            
            var accountItems = [ACBaseItem]()
            
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
                
                let attachmentType = postAttachment["type"]?.stringValue
                
                if attachmentType == "video"
                {
                    let postVideo = postAttachment["video"]?.dictionaryValue
                    let ownerId = postVideo?["owner_id"]?.int64Value
                    let vId = postVideo?["vid"]?.int64Value
                    let title = postVideo?["title"]?.stringValue
                    let description = postVideo?["description"]?.stringValue
                    let views = postVideo?["views"]?.int64Value
                    let placeHolderURL = postVideo?["image"]?.stringValue
                    
                    if let accessKey = postVideo?["access_key"]?.stringValue
                    {
                        let video = ACCellVideo(ownerId: ownerId!, vId: vId!, title: title!, description: description!, views: views!, placeHolderURL: placeHolderURL!, accessKey: accessKey)
                        content.append(video)
                    }
                    else
                    {
                        let video = ACCellVideo(ownerId: ownerId!, vId: vId!, title: title!, description: description!, views: views!, placeHolderURL: placeHolderURL!, accessKey: "")
                        content.append(video)
                    }
                }
                
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
                //                        print("количество в секции - \(content.count)")
                
                let localWallPost = ACWallPost(postId: postId, content: content)
                                
                accountItems.append(localWallPost)
                
                content.removeAll()
            }


            
            if (self.isCancelled)
            {
                self.success(NSArray())
            }
            else
            {
                self.success(accountItems as NSArray) //массив с постами уходит отсюда
            }
            
            semaphore.signal()
            
        }, failureBlock: { (errorCode) in
            self.failure(errorCode)
            semaphore.signal()
        })
        
        _ = semaphore.wait(timeout: DispatchTime.distantFuture)
        
    }
}
