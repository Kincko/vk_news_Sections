//
//  ACFeedViewController.swift
//  vk_news
//
//  Created by MacAdmin on 29.10.16.
//  Copyright © 2016 vvz. All rights reserved.
//

import UIKit

private let kpostsCellXIBName_1 = "ACNewsTableViewCell_1"
private let kPostsCellIndentifier_1 = "kNewsCellIdentifier_1"

private let kpostsCellXIBName_2 = "ACNewsTableViewCell_2"
private let kPostsCellIndentifier_2 = "kNewsCellIdentifier_2"

private let kpostsCellXIBName_3 = "ACNewsTableViewCell_3"
private let kPostsCellIndentifier_3 = "kNewsCellIdentifier_3"

private let kpostsCellXIBName_99 = "ACNewsTableViewCell_99"
private let kPostsCellIndentifier_99 = "kNewsCellIdentifier_99"

class ACFeedViewController: UIViewController
{
    @IBOutlet weak var tableView: UITableView!
}

//MARK: - жизненный цикл
extension ACFeedViewController
{
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        authorize()
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.tableView.register(UINib(nibName: kpostsCellXIBName_1, bundle: nil), forCellReuseIdentifier: kPostsCellIndentifier_1)
        self.tableView.register(UINib(nibName: kpostsCellXIBName_2, bundle: nil), forCellReuseIdentifier: kPostsCellIndentifier_2)
        self.tableView.register(UINib(nibName: kpostsCellXIBName_3, bundle: nil), forCellReuseIdentifier: kPostsCellIndentifier_3)
         self.tableView.register(UINib(nibName: kpostsCellXIBName_99, bundle: nil), forCellReuseIdentifier: kPostsCellIndentifier_99)
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 44
    }
}

//MARK: - авторизация
extension ACFeedViewController
{
    func authorize ()
    {
        ACAuthManager.sharedInstance.login(withUnderlayController: self, success: {
        
            self.getNews()

        }, failure: {
        
        })
    }
}

//MARK:получение данных
extension ACFeedViewController
{
    func getNews ()
    {
        ACNewsManager.getMNews(withCount: 10, success: {
            DispatchQueue.main.async
            {
                    self.tableView.reloadData()
            }
            }) { (errorCode) in
    
        }
    }
}

//MARK: реализация процедуры интерфейса UITableViewDataSource
extension ACFeedViewController: UITableViewDataSource, UITableViewDelegate
{
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return ACNewsManager.getNumberOfSection()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return ACNewsManager.getNumberOfCells(atSection: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let model = ACNewsManager.getCellModel(atSection: indexPath.section, andIndex: indexPath.row)
        var cell: AnyObject!
        
        if model.postTypeId == 1
        {
            cell = tableView.dequeueReusableCell(withIdentifier: kPostsCellIndentifier_1, for: indexPath) as! ACNewsTableViewCell_1
            (cell as! ACNewsTableViewCell_1).configureSelf(withDataModel: model)
         
        }
        
        if model.postTypeId == 2
        {
            cell = tableView.dequeueReusableCell(withIdentifier: kPostsCellIndentifier_2, for: indexPath) as! ACNewsTableViewCell_2
            (cell as! ACNewsTableViewCell_2).configureSelf(withDataModel: model)
         
        }
        
        if model.postTypeId == 3
        {
            cell = tableView.dequeueReusableCell(withIdentifier: kPostsCellIndentifier_3, for: indexPath) as! ACNewsTableViewCell_3
            (cell as! ACNewsTableViewCell_3).configureSelf(withDataModel: model)
          
        }
        
        if model.postTypeId == 99
        {
            cell = tableView.dequeueReusableCell(withIdentifier: kPostsCellIndentifier_99, for: indexPath) as! ACNewsTableViewCell_99
            (cell as! ACNewsTableViewCell_99).configureSelf(withDataModel: model)
        }
        
        return cell as! UITableViewCell
    }
}





