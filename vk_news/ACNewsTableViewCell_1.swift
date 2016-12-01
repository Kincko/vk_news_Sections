//
//  ACNewsTableViewCell_1.swift
//  vk_news
//
//  Created by Gregory House on 10.11.16.
//  Copyright © 2016 vvz. All rights reserved.
//

import UIKit
import SDWebImage

class ACNewsTableViewCell_1: UITableViewCell {

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
extension ACNewsTableViewCell_1
{
    func configureSelf (withDataModel model: ACNews)
    {
        postSourcePhoto.sd_setImage(with: NSURL(string: model.postSourcePhoto) as! URL)
        postSourceName.text = model.postSourceName
    }
}
