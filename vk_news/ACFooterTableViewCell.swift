//
//  ACFooterTableViewCell.swift
//  vk_news
//
//  Created by Gregory House on 26.11.16.
//  Copyright © 2016 vvz. All rights reserved.
//

import UIKit

class ACFooterTableViewCell: UITableViewCell
{
    
    @IBOutlet weak var postLikes: UILabel!
    
}

//MARK: конфигуратор ячейки
extension ACFooterTableViewCell
{
    func configureSelf (withDataModel model: ACCellFooter)
    {
        postLikes.text = String(model.newsLikesCount)
    }
}

