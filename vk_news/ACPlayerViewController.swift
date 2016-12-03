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
    static var videoModel: ACCellVideo!

    var videoURLForPlayer: String = "summer2016.m4v"
    
    override func viewDidAppear(_ animated: Bool)
    {
        print("id видео - \(ACPlayerViewController.videoModel.vId)")
        authorize()
        print("название видео - \(ACPlayerViewController.videoModel.title)")

        let player = AVPlayer(url: NSURL(string: "\(videoURLForPlayer)") as! URL)
        print("адрес видео - \(videoURLForPlayer)")
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
        ACVideoManager.getVideo(withVideoModel: ACPlayerViewController.videoModel, success: {(videoURL) in
        
            DispatchQueue.global(qos: DispatchQoS.QoSClass.background).async
            {
                    self.videoURLForPlayer = videoURL
            }
            
        }) { ( errorCode ) in
        }
    }
}
