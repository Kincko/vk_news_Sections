//
//  ACNewsItem.swift
//  vk_news
//
//  Created by Gregory House on 19.11.16.
//  Copyright © 2016 vvz. All rights reserved.
//

import Foundation

class ACNewsItem
{
    var id: String
    var content: NSArray
    
    init(id: String, content: NSArray)
    {
        self.id = id
        self.content = content
    }
}
