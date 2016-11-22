//
//  ACNewsText.swift
//  vk_news
//
//  Created by Gregory House on 19.11.16.
//  Copyright © 2016 vvz. All rights reserved.
//

import Foundation

class ACNewsText: ACBaseItem
{
    var text: String
    var cellId: Int
    
    init(WithCellID cellId: Int, text: String)
    {
        self.text = text
        self.cellId = cellId
    }
}
