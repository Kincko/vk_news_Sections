//
//  ACNewsTableViewCell_3.swift
//  vk_news
//
//  Created by Gregory House on 10.11.16.
//  Copyright © 2016 vvz. All rights reserved.
//

import UIKit
import SDWebImage

class ACNewsTableViewCell_3: UITableViewCell {

    @IBOutlet weak var postImage: UIImageView!
    
}

//MARK: конфигуратор ячейки
extension ACNewsTableViewCell_3
{
    func configureSelf (withDataModel model: ACNews)
    {
        
        let rawImageView = UIImageView()
        rawImageView.sd_setImage(with: NSURL(string: model.postImage) as! URL, placeholderImage: #imageLiteral(resourceName: "no-thumbnail"))
        
        postImage.image = resizeImage(image: rawImageView.image!, targetSize: CGSize(width: frame.size.width, height: frame.size.width))
        
        
        
    }
}

//MARK: изменение размера картинки
extension ACNewsTableViewCell_3
{

    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage
    {
        let size = image.size
        
        let widthRatio  = targetSize.width  / image.size.width
        let heightRatio = targetSize.height / image.size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        
        if(widthRatio > heightRatio)
        {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        }
        else
        {
            newSize = CGSize(width: size.width * widthRatio, height: size.height * heightRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }

}


