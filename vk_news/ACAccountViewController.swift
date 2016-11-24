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

class ACAccountViewController: UIViewController
{
    @IBOutlet weak var tableView: UITableView!
}
    
//MARK: - жизненный цикл
extension ACAccountViewController
{
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: kpostsCellXIBName_41, bundle: nil), forCellReuseIdentifier: kPostsCellIndentifier_41)
        
        self.tableView.dataSource = self
        
        ACAccountManager.getAccountItems(success: {
            DispatchQueue.main.async
            {
                self.tableView.reloadData()
            }
        }) {( errorCode ) in
        }
    }
}

//MARK: реализация процедуры интерфейса UITableViewDataSource
extension ACAccountViewController: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return ACAccountManager.getNumberOfCells()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let model = ACAccountManager.getCellModel(atIndex: indexPath.row)
        let cell = tableView.dequeueReusableCell(withIdentifier: kPostsCellIndentifier_41, for: indexPath) as! ACAccountHeaderTableViewCell
        cell.configureSelf(withDataModel: model)
        return cell
    }
}





