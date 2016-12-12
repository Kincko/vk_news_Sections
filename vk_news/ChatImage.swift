//
//  ChatImage.swift
//  vk_news
//
//  Created by Admin on 03.12.16.
//  Copyright © 2016 vvz. All rights reserved.
//

import Foundation
import UIKit
import JSQMessagesViewController
import SDWebImage

class ChatImage:NSObject, JSQMessageMediaData
{
    let PhotoURL:URL
    let senderId:String
    
    init(PhotoURL:URL, senderId:String)
    {
        self.PhotoURL = PhotoURL
        self.senderId = senderId
    }
    
   
    func mediaView() -> UIView
    {
        let size = self.mediaViewDisplaySize()
        let imageView = UIImageView()
        imageView.sd_setImage(with: PhotoURL)
        imageView.frame = CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height)
        imageView.contentMode = UIViewContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        if senderId == "1"
        {
            JSQMessagesMediaViewBubbleImageMasker.applyBubbleImageMask(toMediaView: imageView, isOutgoing: true)
        }
        else
        {
            JSQMessagesMediaViewBubbleImageMasker.applyBubbleImageMask(toMediaView: imageView, isOutgoing: false)
        }
        return imageView
    }

    
    func mediaViewDisplaySize() -> CGSize
    {
        let size = CGSize(width: 200, height: 300)
        return size
    }
    
    func mediaPlaceholderView() -> UIView!
    {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "no-thumbnail")
        return imageView
    }
    
    func mediaHash() -> UInt
    {
        let random = Int(arc4random())
        return UInt(random)
    }
}
