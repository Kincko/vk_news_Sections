//
//  ACAccountHeaderTableViewCell.swift
//  vk_news
//
//  Created by Gregory House on 23.11.16.
//  Copyright © 2016 vvz. All rights reserved.
//

import UIKit
import SDWebImage

class ACAccountHeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var accountAvatar: UIImageView!
    @IBOutlet weak var accountFullName: UILabel!
    @IBOutlet weak var accountBDate: UILabel!
    @IBOutlet weak var accountCityName: UILabel!
    @IBOutlet weak var accountFriendsCount: UILabel!
    @IBOutlet weak var accountSubsCount: UILabel!
    @IBOutlet weak var accountPhotoCount: UILabel!
    @IBOutlet weak var accountGroupsCount: UILabel!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        accountAvatar.layer.cornerRadius = 40
        accountAvatar.layer.masksToBounds = true
    }    
}

//MARK: самодержавный конфигуратор ячеечки 
extension ACAccountHeaderTableViewCell
{

    func configureSelf (withDataModel model: ACAccount)
    {
    
        let fullName = model.firstName + " " + model.lastName
        accountFullName.text = fullName
        accountBDate.text = model.bDate
        accountCityName.text = model.cityName
        accountFriendsCount.text = model.counters["friends"] as? String
        accountSubsCount.text = model.counters["subs"] as? String
        accountPhotoCount.text = model.counters["photo"] as? String
        accountGroupsCount.text = model.counters["groups"] as? String
        accountAvatar.sd_setImage(with: NSURL(string: model.avatarURL) as! URL)
    
    }
    
}
