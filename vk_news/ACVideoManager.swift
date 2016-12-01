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

}

//MARK: загрузка ссылки на видео
extension ACVideoManager
{
    class func getVideo (withVideoModel videoModel: ACCellVideo, success: @escaping () -> Void, failure: @escaping (_ errorCode: Int) -> Void) -> Void
    {
        API_WRAPPER.getVideo(forOwnerId: videoModel.ownerId, andVideoId: videoModel.vId, successBlock:{(jsonResponse) in
            
        
        }, failureBlock: failure)
    }
}
