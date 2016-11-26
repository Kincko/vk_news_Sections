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

//MARK: конфигуратор ячеечки
extension ACAccountHeaderTableViewCell
{

    func configureSelf (withDataModel model: ACWallPost)
    {
    
        let propModel = model.content[0] as! ACAccount
        
        let fullName = propModel.firstName + " " + propModel.lastName
        accountFullName.text = fullName
        accountBDate.text = propModel.bDate
        accountCityName.text = propModel.cityName
        accountFriendsCount.text = propModel.counters["friends"] as? String
        accountSubsCount.text = propModel.counters["subs"] as? String
        accountPhotoCount.text = propModel.counters["photos"] as? String
        accountGroupsCount.text = propModel.counters["groups"] as? String
        accountAvatar.sd_setImage(with: NSURL(string: propModel.avatarURL) as! URL)
    }
    
}
