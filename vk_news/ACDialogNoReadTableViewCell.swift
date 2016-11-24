//
//  ACDialogNoReadTableViewCell.swift
//  vk_news
//
//  Created by Admin on 24.11.16.
//  Copyright © 2016 vvz. All rights reserved.
//

import UIKit

class ACDialogNoReadTableViewCell: UITableViewCell {
    
    @IBOutlet weak var Avatar: UIImageView!
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var Message: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        Avatar.layer.cornerRadius = 35
        Avatar.clipsToBounds = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

//MARK: настройка клетки
extension ACDialogNoReadTableViewCell
{
    func configureSelf (withDataModel model: ACDialog)
    {
        Avatar.sd_setImage(with: NSURL(string: model.photoURL) as! URL)
        Name.text = model.name
        Message.text = model.message
    }
}
