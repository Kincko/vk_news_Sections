//
//  ACVideoTableViewCell.swift
//  vk_news
//
//  Created by Gregory House on 30.11.16.
//  Copyright © 2016 vvz. All rights reserved.
//

import UIKit
import SDWebImage

class ACVideoTableViewCell: UITableViewCell {

    @IBOutlet weak var videoPlaceHolder: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var descriptionText: UILabel!
    @IBOutlet weak var views: UILabel!

}

extension ACVideoTableViewCell
{
    func configureSelf (withDataModel model: ACCellVideo)
    {
        
        videoPlaceHolder.sd_setImage(with: NSURL(string: model.placeHolderURL) as! URL)
        title.text = model.title
        descriptionText.text = model.description
        views.text = "views: \(model.views)"
        
    }
}
