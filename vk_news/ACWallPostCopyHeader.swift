//
//  ACWallPostCopyHeader.swift
//  vk_news
//
//  Created by Gregory House on 26.11.16.
//  Copyright © 2016 vvz. All rights reserved.
//

import Foundation

class ACWallPostCopyHeader: ACBaseItem
{
    var cellId: Int
    var copySource: ACCellSource
    init(cellId: Int, copySource: ACCellSource)
    {
        self.cellId = cellId
        self.copySource = copySource
    }
}
