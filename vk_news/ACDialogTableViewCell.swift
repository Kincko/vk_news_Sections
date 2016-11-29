//
//  ACDialogTableViewCell.swift
//  vk_news
//
//  Created by Admin on 24.11.16.
//  Copyright © 2016 vvz. All rights reserved.
//

import UIKit

private let kCollectionViewCellXIBName = "ACAvatarChatCollectionViewCell"
private let kCollectionViewCellReuseIdentifier = "kPostsCellIdentifier"

class ACDialogTableViewCell: UITableViewCell {
    
    @IBOutlet weak var Avatar: UIImageView!
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var Message: UILabel!
    @IBOutlet weak var CollectionView: UICollectionView!
    
    var dataSource = [String]()

    override func awakeFromNib() {
        super.awakeFromNib()
        Avatar.layer.cornerRadius = 35
        Avatar.clipsToBounds = true
        
        CollectionView.layer.cornerRadius = 35
        CollectionView.clipsToBounds = true
        
        CollectionView.register( UINib(nibName: kCollectionViewCellXIBName, bundle: nil), forCellWithReuseIdentifier: kCollectionViewCellReuseIdentifier)
        self.CollectionView.dataSource = self
        self.CollectionView.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

//MARK: настройка клетки
extension ACDialogTableViewCell
{
    func configureSelf (withDataModel model: ACDialog)
    {
        Avatar.sd_setImage(with: NSURL(string: model.photoURL) as! URL)
        Name.text = model.name
        Message.text = model.message
        dataSource = model.avatarArray
        self.CollectionView.reloadData()
    }
    
    func backgroundLabel(color:UIColor)
    {
        Message.backgroundColor = color
    }
}


//MARK: настройка аватара
extension ACDialogTableViewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCollectionViewCellReuseIdentifier, for: indexPath) as! ACAvatarChatCollectionViewCell
        
        cell.configureViewPhoto(photoURL: dataSource[indexPath.row])
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        
        if dataSource.count == 1
        {
            return CGSize(width: 70, height: 70)
        }
        
        if dataSource.count == 2
        {
            return CGSize(width: 34.5, height: 70)
        }
        else
        {
            return CGSize(width: 34.5, height: 34.5)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat
    {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat
    {
        return 1
    }
}
