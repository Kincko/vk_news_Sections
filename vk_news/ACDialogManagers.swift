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
            for dialog in jsonArray
            {
                let uid = dialog["uid"].int64Value
                arrayUser.append("\(uid)")
            }
            
            var accountArray = [JSON]()
            
            API_WRAPPER.getUsers(withUsers: arrayUser, successBlock: { (jsonResponse) in
                
                accountArray = jsonResponse["response"].arrayValue
                //for user in accountArray
                //{
                //    let name = user["first_name"].stringValue + " " + user["last_name"].stringValue
                //    print("Элемент массива: \(name)")
                //}
                
                for dialog in jsonArray
                {
                    let uid = dialog["uid"].int64Value
                    let chatID = dialog["chat_id"].int64Value
                    let read = dialog["read_state"].intValue
                    if uid == 0
                    {
                        continue
                    }
                    
                    var photoURL = ""
                    var name = ""
                    
                if chatID == 0
                {
                    for user in accountArray
                    {
                        if user["uid"].int64Value == uid
                        {
                            name = user["first_name"].stringValue + " " + user["last_name"].stringValue
                            photoURL = user["photo_100"].stringValue
                        }
                    }
                }
                else
                {
                    name = dialog["title"].stringValue
                    photoURL = dialog["photo_100"].stringValue
                }
                    
                    let title = dialog["title"].stringValue
                    let message = dialog["body"].stringValue
                    
                    
                    let model = ACDialog(title: title, message: message, photoURL: photoURL, name: name, read: read)
                    dialogArray.append(model)
                }
                
                success()
                
            }, failureBlock: failure)
            
            
            
            
            
            }, failureBlock: failure)
    
    }
}
