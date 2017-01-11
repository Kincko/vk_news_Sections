//
//  ACVideoManager.swift
//  vk_news
//
//  Created by Gregory House on 12.12.16.
//  Copyright © 2016 vvz. All rights reserved.
//

import Foundation

class ACVideoManager
{
    static var videoURL: String = ""
    static var linksDictionary = NSMutableDictionary()

}

//MARK: загрузка ссылки на видео
extension ACVideoManager
{
    class func getVideo (withVideoModel videoModel: ACCellVideo, success: @escaping (_ videoURL: String) -> Void, failure: @escaping (_ errorCode: Int) -> Void) -> Void
    {
        API_WRAPPER.getVideo(forOwnerId: videoModel.ownerId, andVideoId: videoModel.vId, andAccessKey: videoModel.accessKey, successBlock:{(jsonResponse) in
            let response = jsonResponse["response"].arrayValue
            let video = response[1].dictionaryValue
            if let tempURL = video["player"]?.stringValue
            {
                videoURL = tempURL
            }
            success(videoURL)
        }, failureBlock: failure)
    }
    
    class func getVideoLink (withVideoURL videoURL: String, success: @escaping (_ videoLink: NSMutableDictionary) -> Void, failure: @escaping (_ errorCode: Int) -> Void) -> Void
    {
        API_WRAPPER.getVideoLink(withVideoPlayerURL: videoURL, successBlock:{(xmlDoc) in
            
            if linksDictionary.count == 0
            {

                let xmlString = String(xmlDoc)
            
                if let linkRange240 = xmlString.range(of: "240.mp4")
                {
                    let newLinkRange = xmlString.index(linkRange240.lowerBound, offsetBy: -52)..<xmlString.index(linkRange240.upperBound, offsetBy: 0)
                    let cropedString = xmlString.substring(with: newLinkRange)
                    linksDictionary.setObject(cropedString, forKey: NSString(string: "240"))
                }
            
                if let linkRange360 = xmlString.range(of: "360.mp4")
                {
                    let newLinkRange = xmlString.index(linkRange360.lowerBound, offsetBy: -52)..<xmlString.index(linkRange360.upperBound, offsetBy: 0)
                    let cropedString = xmlString.substring(with: newLinkRange)
                    linksDictionary.setObject(cropedString, forKey: NSString(string: "360"))
                }
            
                if let linkRange480 = xmlString.range(of: "480.mp4")
                {
                    let newLinkRange = xmlString.index(linkRange480.lowerBound, offsetBy: -52)..<xmlString.index(linkRange480.upperBound, offsetBy: 0)
                    let cropedString = xmlString.substring(with: newLinkRange)
                    linksDictionary.setObject(cropedString, forKey: NSString(string: "480"))
                }
            
                if let linkRange720 = xmlString.range(of: "720.mp4")
                {
                    let newLinkRange = xmlString.index(linkRange720.lowerBound, offsetBy: -52)..<xmlString.index(linkRange720.upperBound, offsetBy: 0)
                    let cropedString = xmlString.substring(with: newLinkRange)
                    linksDictionary.setObject(cropedString, forKey: NSString(string: "720"))
                }
            
                if let linkRange1080 = xmlString.range(of: "1080.mp4")
                {
                    let newLinkRange = xmlString.index(linkRange1080.lowerBound, offsetBy: -52)..<xmlString.index(linkRange1080.upperBound, offsetBy: 0)
                    let cropedString = xmlString.substring(with: newLinkRange)
                    linksDictionary.setObject(cropedString, forKey: NSString(string: "1080"))
                }

//                print("\(linksDictionary)")
                success(linksDictionary)
            }
            
            
            
        }, failureBlock: failure)
    }
}
