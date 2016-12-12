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
    
    class func clearArray ()
    {
        messagesArray.removeAll()
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
                        let JSPhoto = ChatImage(PhotoURL: imageURL!, senderId: senderId)
                        messagesArray.append(JSQMessage(senderId: senderId, displayName: displayName, media: JSPhoto))
                        continue
                    }
                    
                    if type == "video"
                    {
                        
                    }
                    
                    
                }
                
                
                messagesArray.append(JSQMessage(senderId: senderId, displayName: displayName, text: text))
                
            }
            
            messagesArray = messagesArray.reversed()
            
            success()
            
            
        }, failureBlock: failure)
    }
    
    class func sendMessages (withUser user: String, withMessage text: String, success: @escaping () -> Void, failure: @escaping (_ errorCode: Int) -> Void) -> Void
    {
        API_WRAPPER.sendMessage(withUser: user, withMessage: text, successBlock: { (jsonResponse) in
            
            
            success()
            
            
        }, failureBlock: failure)
    }
}
