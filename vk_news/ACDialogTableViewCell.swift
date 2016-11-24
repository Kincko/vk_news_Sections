//
//  ACDialogTableViewCell.swift
//  vk_news
//
//  Created by Admin on 24.11.16.
//  Copyright © 2016 vvz. All rights reserved.
//

import UIKit

class ACDialogTableViewCell: UITableViewCell {
    
    @IBOutlet weak var Avatar: UIImageView!
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var Message: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        Avatar.layer.cornerRadius = 35
        Avatar.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

//MARK: настройка клетки
extension ACDialogTableViewCell
{
    func configureSelf (withDataModel model: ACDialog)
    {
        Avatar.sd_setImage(with: NSURL(string: model.photoURL) as! URL)
        Name.text = model.name
        Message.text = model.message
    }
}
