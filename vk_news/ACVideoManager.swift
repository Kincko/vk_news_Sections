//
//  ACVideoManager.swift
//  vk_news
//
//  Created by Gregory House on 01.12.16.
//  Copyright © 2016 vvz. All rights reserved.
//

import Foundation

class ACVideoManager
{
    static var videoURL: String = ""
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
}
