//
//  ACDialog.swift
//  vk_news
//
//  Created by Admin on 23.11.16.
//  Copyright © 2016 vvz. All rights reserved.
//

import Foundation

class ACDialog
{
    var title:String
    var message:String
    var photoURL:String
    var name:String
    var read:Int
    
    
    init(title:String,message:String,photoURL:String,name:String,read:Int)
    {
        self.title = title
        self.message = message
        self.photoURL = photoURL
        self.name = name
        self.read = read
    }
    
    
}
