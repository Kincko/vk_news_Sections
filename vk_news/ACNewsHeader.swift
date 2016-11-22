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
    var source = ACSource
    var cellId: Int
    
    init(WithCellID cellId: Int, source: ACSource)
    {
        self.source = source
        self.cellId = cellId
    }
}
