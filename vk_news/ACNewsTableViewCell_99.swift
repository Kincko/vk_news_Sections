//
//  ACNewsTableViewCell_99.swift
//  vk_news
//
//  Created by Gregory House on 19.11.16.
//  Copyright © 2016 vvz. All rights reserved.
//

import UIKit

class ACNewsTableViewCell_99: UITableViewCell
{
    
    @IBOutlet weak var postLikes: UILabel!
    
}

//MARK: конфигуратор ячейки
extension ACNewsTableViewCell_99
{
    func configureSelf (withDataModel model: ACNews)
    {
        postLikes.text = String(model.postLikesCount)
    }
}
