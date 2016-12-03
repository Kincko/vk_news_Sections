//
//  ACVideoViewController.swift
//  vk_news
//
//  Created by Gregory House on 03.12.16.
//  Copyright © 2016 vvz. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class ACVideoViewController: UIViewController {
    
    static var videoModel: ACCellVideo!
    var vkVideoURL: String = ""
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        authorize()
        print("авторизация в viewDidAppear")
        playVideo()
        print("вызов функции PlayVideo")
    }
}

//MARK: - инициализация плеера
extension ACVideoViewController
{
    func playVideo()
    {
//        guard let path = Bundle.main.path(forResource: "summer2016", ofType:"m4v") else {
//            debugPrint("summer2016.m4v not found")
//            return
//        }
//        let player = AVPlayer(url: URL(fileURLWithPath: path))
        
        let player = AVPlayer(url: NSURL(string: "\(vkVideoURL)") as! URL)
        let playerController = AVPlayerViewController()
        playerController.player = player
        present(playerController, animated: true) {
            player.play()
            print("попытка воспроизведения.... с ссылкой \(self.vkVideoURL)")
        }
    }
}

//MARK: - авторизация
extension ACVideoViewController
{
    func authorize ()
    {
        ACAuthManager.sharedInstance.login(withUnderlayController: self, success: {
            
            self.getVideo()
            print("авторизация")
            
        }, failure: {
            
        })
    }
}

//MARK:получение данных
extension ACVideoViewController
{
    func getVideo ()
    {
        ACVideoManager.getVideo(withVideoModel: ACVideoViewController.videoModel, success: {(videoURL) in
            
            DispatchQueue.global(qos: DispatchQoS.QoSClass.background).async
                {
                    self.vkVideoURL = videoURL
                    print("выполнение кода в очереди, ссылка на видео - \(self.vkVideoURL)")
            }
            
        }) { ( errorCode ) in
        }
    }
}
