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

private let kpostsCellXIBName_42 = "ACNewsTableViewCell_1"
private let kPostsCellIndentifier_42 = "kNewsCellIdentifier_1"

private let kpostsCellXIBName_44 = "ACNewsTableViewCell_2"
private let kPostsCellIndentifier_44 = "kNewsCellIdentifier_2"

private let kpostsCellXIBName_45 = "ACNewsTableViewCell_3"
private let kPostsCellIndentifier_45 = "kNewsCellIdentifier_3"

private let kpostsCellXIBName_46 = "ACNewsTableViewCell_99"
private let kPostsCellIndentifier_46 = "kNewsCellIdentifier_99"

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
        self.tableView.register(UINib(nibName: kpostsCellXIBName_44, bundle: nil), forCellReuseIdentifier: kPostsCellIndentifier_44)
        self.tableView.register(UINib(nibName: kpostsCellXIBName_45, bundle: nil), forCellReuseIdentifier: kPostsCellIndentifier_45)
        self.tableView.register(UINib(nibName: kpostsCellXIBName_46, bundle: nil), forCellReuseIdentifier: kPostsCellIndentifier_46)
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
        return ACAccountManager.getNumberOfCells(atSection: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let model = ACAccountManager.getCellModel(atIndex: indexPath
        .section)
        
        var cell: AnyObject!
        
        print("\(model.postId)")
        
        if model.postId == "info"
        {
            cell = tableView.dequeueReusableCell(withIdentifier: kPostsCellIndentifier_41, for: indexPath) as! ACAccountHeaderTableViewCell
            (cell as! ACAccountHeaderTableViewCell).configureSelf(withDataModel: model)
        }
        else
        {
            cell = tableView.dequeueReusableCell(withIdentifier: kPostsCellIndentifier_100, for: indexPath) as! ACUnderCTableViewCell
        }
        return cell as! UITableViewCell
    }
}





