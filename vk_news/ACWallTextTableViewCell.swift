//
//  ACWallTextTableViewCell.swift
//  vk_news
//
//  Created by Gregory House on 26.11.16.
//  Copyright © 2016 vvz. All rights reserved.
//

import UIKit

class ACWallTextTableViewCell: UITableViewCell
{
    @IBOutlet weak var postText: UILabel!
    
}
//MARK: конфигуратор ячейки
extension ACWallTextTableViewCell
{
    func configureSelf (withDataModel model: ACCellText)
    {
        postText.text = model.text
    }
}
