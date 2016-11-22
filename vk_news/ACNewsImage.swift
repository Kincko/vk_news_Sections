//
//  ACNewsImage.swift
//  vk_news
//
//  Created by Gregory House on 19.11.16.
//  Copyright © 2016 vvz. All rights reserved.
//

import Foundation

class ACNewsImage: ACBaseItem
{
    var imageURL: String
    var cellId: Int
    
    init (WithCellID cellId: Int, imageURL: String)
    {
        self.imageURL = imageURL
        self.cellId = cellId
    }
}
