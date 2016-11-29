//
//  ACAvatarChatCollectionViewCell.swift
//  vk_news
//
//  Created by Admin on 26.11.16.
//  Copyright © 2016 vvz. All rights reserved.
//

import UIKit

class ACAvatarChatCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var ViewPhoto: UIImageView!
    
    
    func configureViewPhoto(photoURL:String)
    {
        ViewPhoto.sd_setImage(with: NSURL(string: photoURL) as! URL)
    }

}


