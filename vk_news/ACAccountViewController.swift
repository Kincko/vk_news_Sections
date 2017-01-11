//
//  ACAccountViewController.swift
//  vk_news
//
//  Created by Gregory House on 22.11.16.
//  Copyright © 2016 vvz. All rights reserved.
//

import UIKit

private let kpostsCellXIBName_41 = "ACAccountHeaderTableViewCell"
private let kPostsCellIndentifier_41 = "ACAccountHeaderCellIndentifier"

private let kpostsCellXIBName_42 = "ACWallHeaderTableViewCell"
private let kPostsCellIndentifier_42 = "kNewsCellIdentifier_42"

private let kpostsCellXIBName_43 = "ACWallCopySourceTableViewCell"
private let kPostsCellIndentifier_43 = "kNewsCellIdentifier_43"

private let kpostsCellXIBName_44 = "ACWallTextTableViewCell"
private let kPostsCellIndentifier_44 = "kNewsCellIdentifier_44"

private let kpostsCellXIBName_45 = "ACImageTableViewCell"
private let kPostsCellIndentifier_45 = "kNewsCellIdentifier_45"

private let kpostsCellXIBName_46 = "ACFooterTableViewCell"
private let kPostsCellIndentifier_46 = "kNewsCellIdentifier_46"

private let kpostsCellXIBName_47 = "ACVideoTableViewCell"
private let kPostsCellIndentifier_47 = "kNewsCellIdentifier_47"

private let kpostsCellXIBName_100 = "ACUnderCTableViewCell"
private let kPostsCellIndentifier_100 = "kNewsCellIdentifier_100"

class ACAccountViewController: UIViewController
{
    @IBOutlet weak var tableView: UITableView!
}
    
//MARK: - жизненный цикл
extension ACAccountViewController
{
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        authorize()
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.tableView.register(UINib(nibName: kpostsCellXIBName_41, bundle: nil), forCellReuseIdentifier: kPostsCellIndentifier_41)
        self.tableView.register(UINib(nibName: kpostsCellXIBName_42, bundle: nil), forCellReuseIdentifier: kPostsCellIndentifier_42)
        self.tableView.register(UINib(nibName: kpostsCellXIBName_43, bundle: nil), forCellReuseIdentifier: kPostsCellIndentifier_43)
        self.tableView.register(UINib(nibName: kpostsCellXIBName_44, bundle: nil), forCellReuseIdentifier: kPostsCellIndentifier_44)
        self.tableView.register(UINib(nibName: kpostsCellXIBName_45, bundle: nil), forCellReuseIdentifier: kPostsCellIndentifier_45)
        self.tableView.register(UINib(nibName: kpostsCellXIBName_46, bundle: nil), forCellReuseIdentifier: kPostsCellIndentifier_46)
        self.tableView.register(UINib(nibName: kpostsCellXIBName_47, bundle: nil), forCellReuseIdentifier: kPostsCellIndentifier_47)
        self.tableView.register(UINib(nibName: kpostsCellXIBName_100, bundle: nil), forCellReuseIdentifier: kPostsCellIndentifier_100)

        
        self.tableView.dataSource = self
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 44
        
    }
}

//MARK: - авторизация
extension ACAccountViewController
{
    func authorize ()
    {
        ACAuthManager.sharedInstance.login(withUnderlayController: self, success: {
            
            self.getAccount()
            
        }, failure: {
            
        })
    }
}

//MARK:получение данных
extension ACAccountViewController
{
    func getAccount ()
    {
        ACAccountManager.getAccountItems(success: {
            DispatchQueue.main.async
            {
                    self.tableView.reloadData()
            }
            }) { ( errorCode ) in
        }
    }
}

//MARK: реализация процедуры интерфейса UITableViewDataSource
extension ACAccountViewController: UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return ACAccountManager.getNumberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
//        print("\(ACAccountManager.getNumberOfCells(atSection: section))")
        return ACAccountManager.getNumberOfCells(atSection: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let model = ACAccountManager.getCellModel(atIndex: indexPath.section)
        
        var cell: AnyObject!
        
        if model.postId == "info"
        {
            cell = tableView.dequeueReusableCell(withIdentifier: kPostsCellIndentifier_41, for: indexPath) as! ACAccountHeaderTableViewCell
            (cell as! ACAccountHeaderTableViewCell).configureSelf(withDataModel: model)
//            print("ячейка info")
        }
        
        let cellModels = model.content
        
        let cellModel = cellModels[indexPath.row]
        
        if cellModel is ACCellHeader
        {
            cell = tableView.dequeueReusableCell(withIdentifier: kPostsCellIndentifier_42, for: indexPath) as! ACWallHeaderTableViewCell
            (cell as! ACWallHeaderTableViewCell).configureSelf(withDataModel: cellModel as! ACCellHeader)
//            print("ячейка хедер")
        }
            
        if cellModel is ACWallPostCopyHeader
        {
            cell = tableView.dequeueReusableCell(withIdentifier: kPostsCellIndentifier_43, for: indexPath) as! ACWallCopySourceTableViewCell
            (cell as! ACWallCopySourceTableViewCell).configureSelf(withDataModel: cellModel as! ACWallPostCopyHeader)
//            print("ячейка источник")
        }
            
        if cellModel is ACCellText
        {
            cell = tableView.dequeueReusableCell(withIdentifier: kPostsCellIndentifier_44, for: indexPath) as! ACWallTextTableViewCell
            (cell as! ACWallTextTableViewCell).configureSelf(withDataModel: cellModel as! ACCellText)
//            print("ячейка текст")
        }

        if cellModel is ACCellImage
        {
            cell = tableView.dequeueReusableCell(withIdentifier: kPostsCellIndentifier_45, for: indexPath) as! ACImageTableViewCell
            (cell as! ACImageTableViewCell).configureSelf(withDataModel: cellModel as! ACCellImage)
//            print("ячейка изображение")
        }
        
        if cellModel is ACCellVideo
        {
            cell = tableView.dequeueReusableCell(withIdentifier: kPostsCellIndentifier_47, for: indexPath) as! ACVideoTableViewCell
            (cell as! ACVideoTableViewCell).configureSelf(withDataModel: cellModel as! ACCellVideo)
//            print("ячейка видео")
        }
        
        if cellModel is ACCellFooter
        {
            cell = tableView.dequeueReusableCell(withIdentifier: kPostsCellIndentifier_46, for: indexPath) as! ACFooterTableViewCell
            (cell as! ACFooterTableViewCell).configureSelf(withDataModel: cellModel as! ACCellFooter)
//            print("ячейка футер")
        }
        
        print("возврат ячейки, секция - \(indexPath.section), ряд - \(indexPath.row)")
        return cell as! UITableViewCell
    }
}





