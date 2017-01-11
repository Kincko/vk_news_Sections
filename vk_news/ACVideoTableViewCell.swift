//
//  ACVideoTableViewCell.swift
//  vk_news
//
//  Created by Gregory House on 30.11.16.
//  Copyright © 2016 vvz. All rights reserved.
//

import UIKit
import SDWebImage
import AVFoundation

class ACVideoTableViewCell: UITableViewCell {
    
    static var videoModel: ACCellVideo!
    
    @IBOutlet weak var videoPlaceHolder: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var descriptionText: UILabel!
    @IBOutlet weak var views: UILabel!
    @IBOutlet weak var playButton: UIButton!
    
    var playerLayer: AVPlayerLayer?
    var player: AVPlayer?
    var vkVideoURL: String = ""
    
    let activityIndicatorView: UIActivityIndicatorView = {
        
        let aiv = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        aiv.translatesAutoresizingMaskIntoConstraints = false
        aiv.hidesWhenStopped = true
        
        return aiv
    }()
    
    func getVideo()
    {
        ACVideoManager.linksDictionary.removeAllObjects()
        
        ACVideoManager.getVideo(withVideoModel: ACVideoTableViewCell.videoModel, success: {(videoURL) in
            
            DispatchQueue.main.async
                {
                    self.vkVideoURL = videoURL
                    print("при нажатии кнопки получены ссылка на видео - \(self.vkVideoURL)")
                    self.getLink()
            }
            
        }) { ( errorCode ) in
        }
    }
    
    func getLink()
    {
        
        ACVideoManager.getVideoLink(withVideoURL: vkVideoURL, success:{(videoLinks) in
            
            DispatchQueue.main.async {
                self.vkVideoURL = videoLinks.value(forKey: "720") as! String
                print("после получения прямой ссылки из файла имеем ссылку - \(self.vkVideoURL)")
                self.playVideo()
            }
            
        }) { ( errorCode ) in
        }
    }
    
    func playVideo()
    {
        player = AVPlayer(url: NSURL(string: "\(vkVideoURL)") as! URL)
        playerLayer = AVPlayerLayer(player: player)
        playerLayer?.frame = videoPlaceHolder.bounds
        videoPlaceHolder.layer.addSublayer(playerLayer!)
        player?.play()
        activityIndicatorView.startAnimating()
        playButton.isHidden = true
        print("воспроизведение.... с ссылкой \(self.vkVideoURL)")
    }
    
    override func prepareForReuse()
    {
        super.prepareForReuse()
        playerLayer?.removeFromSuperlayer()
        player?.pause()
        activityIndicatorView.stopAnimating()
        playButton.isHidden = false
    }
    
    override func awakeFromNib()
    {
        playButton.addTarget(self, action: #selector(getVideo), for: .touchUpInside)
        
        videoPlaceHolder.addSubview(activityIndicatorView)
        activityIndicatorView.centerXAnchor.constraint(equalTo: videoPlaceHolder.centerXAnchor).isActive = true
        activityIndicatorView.centerYAnchor.constraint(equalTo: videoPlaceHolder.centerYAnchor).isActive = true
        activityIndicatorView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        activityIndicatorView.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
}

//MARK: конфигурация ячейки
extension ACVideoTableViewCell
{
    func configureSelf (withDataModel model: ACCellVideo)
    {
        
        ACVideoTableViewCell.videoModel = model
        videoPlaceHolder.sd_setImage(with: NSURL(string: model.placeHolderURL) as! URL)
        title.text = model.title
        descriptionText.text = model.description
        views.text = "views: \(model.views)"
        print("пришло видео с названием - \(model.title)")
        
    }
}
