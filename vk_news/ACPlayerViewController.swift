//
//  ACPlayerViewController.swift
//  vk_news
//
//  Created by Gregory House on 01.12.16.
//  Copyright © 2016 vvz. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import AVKit

class ACPlayerViewController: AVPlayerViewController
{
    var videoModel: ACCellVideo!

    
    override func viewDidAppear(_ animated: Bool)
    {
        authorize()
        let videoURL = NSURL(string: "https://vk.com/video_ext.php?oid=3623650&id=456239041&hash=e8c8178c2812f863")
        let player = AVPlayer(url: videoURL! as URL)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        self.present(playerViewController, animated: true) {
            playerViewController.player!.play()
        }
    }
}

//MARK: - авторизация
extension ACPlayerViewController
{
    func authorize ()
    {
        ACAuthManager.sharedInstance.login(withUnderlayController: self, success: {
            
            self.getVideo()
            
        }, failure: {
            
        })
    }
}

//MARK:получение данных
extension ACPlayerViewController
{
    func getVideo ()
    {
        
        ACVideoManager.getVideo(withVideoModel: videoModel, success: {
        
            
            
        }) {( errorCode ) in
        }
//        ACAccountManager.getAccountItems(success: {
//            DispatchQueue.main.async
//            {
//                    
//            }
//        }) { ( errorCode ) in
//        }
    }
}
