//
//  ACNewsManagers.swift
//  vk_news
//
//  Created by Gregory House on 05.11.16.
//  Copyright © 2016 vvz. All rights reserved.
//



import Foundation

//MARK: интерфейс и доступ к данным
class ACNewsManager
{
    
    static var newsArray = [[ACNews]]()
    
    class func getNumberOfSection () -> Int
    {
        return newsArray.count
    }
    
    class func getNumberOfCells (atSection section: Int) -> Int
    {
        return newsArray[section].count
    }
    
    class func getCellModel (atSection section: Int, andIndex index: Int) -> ACNews
    {
        return newsArray[section][index]
    }
    
//    class func model (atIndex index: Int) -> ACNews
//    {
//        return newsArray[index]
//    }
//    
//    class func numberOfModels () -> Int
//    {
//        return newsArray.count
//    }
    
}

//MARK: загрузка данных из интернета
extension ACNewsManager
{
    class func getMNews (withCount count: Int, success: @escaping () -> Void, failure: @escaping (_ errorCode: Int) -> Void) -> Void
    {
        API_WRAPPER.getNews(withCount: count, successBlock: { (jsonResponse) in
            
            let response = jsonResponse["response"]
            
            let postsArray = response["items"].arrayValue
            let usersArray = response["profiles"].arrayValue
            let groupsArray = response["groups"].arrayValue

            for post in postsArray
            {
//                let postId = post["post_id"].int64Value
                let postText = post["text"].stringValue
                let postSource_id = post["source_id"].int64Value
                
                let postAttachment = post["attachment"].dictionaryValue
                let postImages = postAttachment["photo"]?.dictionaryValue
                let postImage = postImages?["src_big"]?.stringValue
                
                var postSourceName: String = ""
                var postSourcePhoto: String = ""
                
                let postLikes = post["likes"].dictionaryValue
                let postLikesCount = postLikes["count"]!.int64Value
                
                //Парсинг данных для header
                if postSource_id > 0
                {
                    for user in usersArray
                    {
                        let userID = user["uid"].int64Value
                        
                        if userID == postSource_id
                        {
                            let postSourceFirstName = user["first_name"].stringValue
                            let postSourceLastName = user["last_name"].stringValue
                            
                            postSourceName = postSourceFirstName + " " + postSourceLastName
                            postSourcePhoto = user["photo_medium_rec"].stringValue
                        }
                    }
                }
                else
                {
                    let gid = postSource_id * -1
                    
                    for group in groupsArray
                    {
                        let groupId = group["gid"].int64Value
                        
                        if gid == groupId
                        {
                            postSourceName = group["name"].stringValue
                            postSourcePhoto = group["photo_big"].stringValue
                        }
                        
                    }
                    
                }
                
                //инициализация массива новостей
                var models = [ACNews]()
                
                //фомирование данных для ячейки header, добавление в массив новости
                var modelHeader: ACNews
                
                modelHeader = ACNews(fromSourceName: postSourceName, postSourcePhoto: postSourcePhoto, postText: "", postImage: "", postTypeId: 1, postLikesCount: 0)
                models.append(modelHeader)
                
                
                //формирование данных для ячейки text, добавление в массив новости
                var modelText: ACNews? = nil
                if postText != ""
                {
                    modelText = ACNews(fromSourceName: "", postSourcePhoto: "", postText: postText, postImage: "", postTypeId: 2, postLikesCount: 0)
                    models.append(modelText!)
                }
                
                //формирование данных для ячейки картинки, добавление в массив новости
                var modelImage: ACNews? = nil
                if postImage != nil
                {
                    modelImage = ACNews(fromSourceName: "", postSourcePhoto: "", postText: "", postImage: postImage!, postTypeId: 3, postLikesCount: 0)
                    models.append(modelImage!)
                }
                
                //формирование и добавление в конец массива модель футера
                var modelFooter: ACNews
                modelFooter = ACNews(fromSourceName: "", postSourcePhoto: "", postText: "", postImage: "", postTypeId: 99, postLikesCount: postLikesCount)
                models.append(modelFooter)
                
                //добавление новости в массив новостей
                newsArray.append(models)
                
//                if postText != "" && postImage == nil
//                {
//                    model = ACNews(fromSourceName: postSourceName, postSourcePhoto: postSourcePhoto, postText: postText, postImage: "", postTypeId: 1)
//                    newsArray.append(model)
//                }
//                
//                if postText == "" && postImage != nil
//                {
//                    model = ACNews(fromSourceName: postSourceName, postSourcePhoto: postSourcePhoto, postText: postText, postImage: postImage!, postTypeId: 2)
//                    newsArray.append(model)
//                }
//                
//                if postText != "" && postImage != nil
//                {
//                    model = ACNews(fromSourceName: postSourceName, postSourcePhoto: postSourcePhoto, postText: postText, postImage: postImage!, postTypeId: 3)
//                    newsArray.append(model)
//                }
                
            }
            
            success()
            
            
                        }, failureBlock: failure)
    }
}
