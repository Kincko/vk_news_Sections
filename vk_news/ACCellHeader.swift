//
//  ACCellHeader.swift
//  vk_news
//
//  Created by Gregory House on 26.11.16.
//  Copyright © 2016 vvz. All rights reserved.
//

import Foundation

class ACCellHeader: ACBaseItem
{
    var cellId: Int
    var source: ACCellSource
    init(cellId: Int, source: ACCellSource)
    {
        self.cellId = cellId
        self.source = source
    }
    
    
}
