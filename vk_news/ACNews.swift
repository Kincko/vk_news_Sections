//
//  ACNews.swift
//  vk_news
//
//  Created by Gregory House on 05.11.16.
//  Copyright © 2016 vvz. All rights reserved.
//

import Foundation

class ACNews
{
    var postSourceName: String
    var postSourcePhoto: String
    
    var postText: String
    var postImage: String
    
    var postTypeId: Int //id клетки 1 - header, 2 - text, 3 - image, 99 - footer
    
    var postLikesCount: Int64
    
    init(fromSourceName postSourceName: String, postSourcePhoto: String, postText: String, postImage: String, postTypeId: Int, postLikesCount: Int64)
    {
        self.postSourceName = postSourceName
        self.postSourcePhoto = postSourcePhoto
        self.postText = postText
        self.postImage = postImage
        self.postTypeId = postTypeId
        self.postLikesCount = postLikesCount
    }
}



//NSMutableArray
////разные модели данных для разных секций -хэд, текст фотка, футер
//в массив эти модели
//при инициализации проверить какая модель
//двумерный количество секции - каунт новостей количество ячеек - каунт в массиве моделей (поля в ячейке)
