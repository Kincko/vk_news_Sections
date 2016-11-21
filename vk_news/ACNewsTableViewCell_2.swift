//
//  ACNewsTableViewCell_2.swift
//  vk_news
//
//  Created by Gregory House on 08.11.16.
//  Copyright © 2016 vvz. All rights reserved.
//

import UIKit

class ACNewsTableViewCell_2: UITableViewCell
{
    @IBOutlet weak var postText: UILabel!
    
}
//MARK: конфигуратор ячейки
extension ACNewsTableViewCell_2
{
    func configureSelf (withDataModel model: ACNews)
    {
        postText.text = model.postText
    }
}
