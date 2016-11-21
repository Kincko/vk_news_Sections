//
//  ACNewsHeader.swift
//  vk_news
//
//  Created by Gregory House on 19.11.16.
//  Copyright © 2016 vvz. All rights reserved.
//

import Foundation

class ACNewsHeader
{
    var newsSourceName: String
    var newsSourceImage: String
    var cellId: Int
    
    init(WithCellID cellId: Int, newsSourceName: String, newsSourceImage: String)
    {
        self.newsSourceName = newsSourceName
        self.newsSourceImage = newsSourceImage
        self.cellId = cellId
    }
}
