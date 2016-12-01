//
//  ACWallPost.swift
//  vk_news
//
//  Created by Gregory House on 26.11.16.
//  Copyright © 2016 vvz. All rights reserved.
//

import Foundation

class ACWallPost: ACBaseItem
{
    var postId: String
    var content: [ACBaseItem]
    init(postId: String, content: [ACBaseItem])
    {
        self.postId = postId
        self.content = content
    }
}
