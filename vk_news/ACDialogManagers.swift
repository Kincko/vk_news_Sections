//
//  ACDialogManagers.swift
//  vk_news
//
//  Created by Admin on 23.11.16.
//  Copyright © 2016 vvz. All rights reserved.
//

import Foundation

class ACDialogManager
{
    static var dialogArray = [ACDialog]()
    
    class func getNumberOfCells () -> Int
    {
        return dialogArray.count
    }
    
    class func model (atIndex index: Int) -> ACDialog
    {
        return dialogArray[index]
    }
}

//MARK: загрузка данных из интернета
extension ACDialogManager
{
    class func getMDialog (withCount count: Int, success: @escaping () -> Void, failure: @escaping (_ errorCode: Int) -> Void) -> Void
    {
        
        API_WRAPPER.getDialogs(withCount: count, successBlock: { (jsonResponse) in
            
            let jsonArray = jsonResponse["response"].arrayValue
            var arrayUser = [String]()
            var accountArray = [JSON]()
            
            //Массив аакаунтов для запроса доп. информации
            for dialog in jsonArray
            {
                let IDChat = dialog["chat_id"].int64Value
                let uid = dialog["uid"].int64Value
                if IDChat == 0
                {
                    arrayUser.append("\(uid)")
                }
                else
                {
                    let usersChat = dialog["chat_active"].stringValue
                    let arrayUsersChat = usersChat.components(separatedBy: ",")
                    for user in arrayUsersChat
                    {
                        arrayUser.append("\(user)")
                    }
                }
            }
            
            
            API_WRAPPER.getUsers(withUsers: arrayUser, successBlock: { (jsonResponse) in
                
                accountArray = jsonResponse["response"].arrayValue
                
                for dialog in jsonArray
                {
                    let uid = dialog["uid"].int64Value
                    let chatID = dialog["chat_id"].int64Value
                    let read = dialog["read_state"].intValue
                    var photoURL = ""
                    var name = ""
                    let userID = String(uid)
                    
                    //Если есть пустой элемент, пропускаем его
                    if uid == 0
                    {
                        continue
                    }
                    
                    var arrayAvatar = [String]()
                    
                    //Проверяем беседа или обычный диалог
                    if chatID == 0
                    {
                        for user in accountArray
                        {
                            if user["uid"].int64Value == uid
                            {
                                name = user["first_name"].stringValue + " " + user["last_name"].stringValue
                                photoURL = user["photo_100"].stringValue
                                arrayAvatar.append(photoURL)
                            }
                        }
                    }
                    else
                    {
                        name = dialog["title"].stringValue
                        photoURL = dialog["photo_100"].stringValue
                        
                        if photoURL == ""
                        {
                            let usersChat = dialog["chat_active"].stringValue
                            let arrayUsersChat = usersChat.components(separatedBy: ",")
                            for userChat in arrayUsersChat
                            {
                                for user in accountArray
                                {
                                    let stringID = String(user["uid"].int64Value)
                                    if  stringID == userChat
                                    {
                                        let avatarUserChat = user["photo_100"].stringValue
                                        arrayAvatar.append(avatarUserChat)
                                    }
                                }
                            }
                        }
                        else
                        {
                            arrayAvatar.append(photoURL)
                        }
                    }
                    
                    let title = dialog["title"].stringValue
                    var message = dialog["body"].stringValue
                    let out = dialog["out"].intValue
                    
                    //Если нет сообщения, значит там вложение (запись, фото, видео)
                    if message == ""
                    {
                        let attachment = dialog["attachment"].dictionary
                        
                        let type = attachment?["type"]?.stringValue
                        
                        if type == "wall"
                        {
                            message = "Запись"
                        }
                        
                        if type == "photo"
                        {
                            message = "Фотография"
                        }
                        
                        if type == "video"
                        {
                            message = "Видеозапись"
                        }
                        
                        
                    }
                
                    let model = ACDialog(title: title, message: message, photoURL: photoURL, name: name, read: read, out: out, avatarArray: arrayAvatar, userID: userID)
                    dialogArray.append(model)
                }
                
                    success()
                
                }, failureBlock: failure)
            
            }, failureBlock: failure)
    
    }
}
