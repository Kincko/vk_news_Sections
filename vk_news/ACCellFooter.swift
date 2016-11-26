//
//  ACCellFooter.swift
//  vk_news
//
//  Created by Gregory House on 26.11.16.
//  Copyright © 2016 vvz. All rights reserved.
//

import Foundation

class ACCellFooter: ACBaseItem
{
    var cellId: Int
    var newsLikesCount: Int64
    
    init(WithCellID cellId: Int, newsLikesCount: Int64)
    {
        self.newsLikesCount = newsLikesCount
        self.cellId = cellId
    }
}
