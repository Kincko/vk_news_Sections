//
//  ACCellVideo.swift
//  vk_news
//
//  Created by Gregory House on 30.11.16.
//  Copyright © 2016 vvz. All rights reserved.
//

import Foundation

class ACCellVideo: ACBaseItem
{
    var ownerId: Int64
    var vId: Int64
    var title: String
    var description: String
    var views: Int64
    var placeHolderURL: String
    init(ownerId: Int64, vId: Int64, title: String, description: String, views: Int64, placeHolderURL: String)
    {
        self.ownerId = ownerId
        self.vId = vId
        self.title = title
        self.description = description
        self.views = views
        self.placeHolderURL = placeHolderURL
    }
}
