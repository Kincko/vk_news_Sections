//
//  ACWallHeaderTableViewCell.swift
//  vk_news
//
//  Created by Gregory House on 26.11.16.
//  Copyright © 2016 vvz. All rights reserved.
//

import UIKit
import SDWebImage

class ACWallHeaderTableViewCell: UITableViewCell {
    
    @IBOutlet weak var postSourcePhoto: UIImageView!
    @IBOutlet weak var postSourceName: UILabel!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        
        postSourcePhoto.layer.cornerRadius = 25
        postSourcePhoto.layer.masksToBounds = true
    }
}

//MARK: конфигуратор ячейки
extension ACWallHeaderTableViewCell
{
    func configureSelf (withDataModel model: ACCellHeader)
    {
        postSourceName.text = model.source.sourceName
        postSourcePhoto.sd_setImage(with: NSURL(string: model.source.sourceImage) as! URL)
    }
}

