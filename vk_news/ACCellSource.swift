//
//  ACCellSource.swift
//  vk_news
//
//  Created by Gregory House on 26.11.16.
//  Copyright © 2016 vvz. All rights reserved.


import Foundation

class ACCellSource: ACBaseItem
{
    var sourceName: String
    var sourceImage: String
    var sourceId: Int64
    init (WithSourceID sourceId: Int64, sourceName: String, sourceImage: String)
    {
        self.sourceId = sourceId
        self.sourceName = sourceName
        self.sourceImage = sourceImage
    }
}
