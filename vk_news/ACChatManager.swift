//
//  ACChatManager.swift
//  vk_news
//
//  Created by Admin on 01.12.16.
//  Copyright © 2016 vvz. All rights reserved.
//

import Foundation
import JSQMessagesViewController
import SDWebImage

class ACChatManager
{
    static var messagesArray = [JSQMessage]()
    
    class func getNumberOfCells () -> Int
    {
        return messagesArray.count
    }
    
    class func model () -> [JSQMessage]
    {
        return messagesArray
    }
}

//MARK: загрузка данных из интернета
extension ACChatManager
{
    class func getChatMessages (withUser user: String, success: @escaping () -> Void, failure: @escaping (_ errorCode: Int) -> Void) -> Void
    {
        API_WRAPPER.getChatMessages(withUser: user, successBlock: { (jsonResponse) in
            
            let arrayMessages = jsonResponse["response"].arrayValue
            
            for message in arrayMessages
            {
                let uid = message["uid"].int64Value
                if uid == 0
                {
                    continue
                }
                
                let senderId = String(message["out"].int64Value)
                let displayName = "Имя Фамилия"
                let text = message["body"].stringValue
                var check = 1
                /*
                if text == ""
                {
                    let attachment = message["attachment"].dictionary
                    
                    let type = attachment?["type"]?.stringValue
                    
                    if type == "wall"
                    {
                        
                    }
                    
                    if type == "photo"
                    {
                        let photoAttachment = attachment?["photo"]?.dictionary
                        let photoURL = photoAttachment?["src_big"]?.stringValue
                        let imageURL = URL(string: photoURL!)
                        let photo = UIImage()
                        //let photoManager = SDWebImageManager()
                        //photoManager.saveImage(toCache: photo, for: url)
                        var manager:SDWebImageManager = SDWebImageManager.shared()
                        manager.downloadImage(with: imageURL,
                                                          options: SDWebImageOptions.highPriority,
                                                          progress: nil,
                                                          completed: {[] (image, error, cached, finished, url) in
                                                            if (error == nil && (image != nil) && finished) {
                                                                // do something with image
                                                                
                                                                messagesArray.append(JSQMessage(senderId: senderId, displayName: displayName, media: JSPhoto))
                                                                check = 0
                                                            }
                        })
                        
                        let JSPhoto = JSQPhotoMediaItem(
                    }
                    
                    if type == "video"
                    {
                        
                    }
                    
                    
                }
                */
                if check == 1
                {
                messagesArray.append(JSQMessage(senderId: senderId, displayName: displayName, text: text))
                }
            }
            
            messagesArray = messagesArray.reversed()
            
            success()
            
            
        }, failureBlock: failure)
    }
}
