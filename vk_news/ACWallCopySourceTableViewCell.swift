//
//  ACWallCopySourceTableViewCell.swift
//  vk_news
//
//  Created by Gregory House on 26.11.16.
//  Copyright © 2016 vvz. All rights reserved.
//

import UIKit

import UIKit
import SDWebImage

class ACWallCopySourceTableViewCell: UITableViewCell {
    
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
extension ACWallCopySourceTableViewCell
{
    func configureSelf (withDataModel model: ACWallPostCopyHeader)
    {
        postSourceName.text = model.copySource.sourceName
        postSourcePhoto.sd_setImage(with: NSURL(string: model.copySource.sourceImage) as! URL)
    }
}
