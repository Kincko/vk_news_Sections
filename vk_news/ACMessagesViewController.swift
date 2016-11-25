//
//  ACMessagesViewController.swift
//  vk_news
//
//  Created by Gregory House on 22.11.16.
//  Copyright © 2016 vvz. All rights reserved.
//

import UIKit

private let kpostsCellXIBName = "ACDialogTableViewCell"
private let kPostsCellIndentifier = "kPostsCellIdentifier"

private let kpostsCellXIBName1 = "ACDialogNoReadTableViewCell"
private let kPostsCellIndentifier1 = "kPostsCellIdentifier1"

class ACMessagesViewController: UIViewController
{
    @IBOutlet weak var tableView: UITableView!
}

//MARK: - жизненный цикл
extension ACMessagesViewController
{
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        authorize()
        
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: kpostsCellXIBName, bundle: nil), forCellReuseIdentifier: kPostsCellIndentifier)
        self.tableView.register(UINib(nibName: kpostsCellXIBName1, bundle: nil), forCellReuseIdentifier: kPostsCellIndentifier1)
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
}

//MARK: - авторизация
extension ACMessagesViewController
{
    func authorize ()
    {
        ACAuthManager.sharedInstance.login(withUnderlayController: self, success: {
            
            self.getDialogs()
            
            }, failure: {
                
        })
    }
}

//MARK:получение данных
extension ACMessagesViewController
{
    func getDialogs()
    {
        ACDialogManager.getMDialog(withCount: 10, success: {
            DispatchQueue.main.async
                {
                    self.tableView.reloadData()
            }
        }) { (errorCode) in
            
        }
    }
}

//MARK: реализация процедуры интерфейса UITableViewDataSource
extension ACMessagesViewController: UITableViewDataSource, UITableViewDelegate
{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return ACDialogManager.getNumberOfCells()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let model = ACDialogManager.model(atIndex: indexPath.row)
        if model.read == 1     //Если прочитано
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: kPostsCellIndentifier, for: indexPath) as! ACDialogTableViewCell
            cell.configureSelf(withDataModel: model)
            cell.backgroundLabel(color: UIColor.clear)
            return cell
        }
        else
        {
            if model.out == 0    //Если не прочитано
            {
                let cell = tableView.dequeueReusableCell(withIdentifier: kPostsCellIndentifier1, for: indexPath) as! ACDialogNoReadTableViewCell
                cell.configureSelf(withDataModel: model)
                return cell
            }
            else   //Если отправлено мной и еще не прочитали
            {
                let cell = tableView.dequeueReusableCell(withIdentifier: kPostsCellIndentifier, for: indexPath) as! ACDialogTableViewCell
                cell.configureSelf(withDataModel: model)
                cell.backgroundLabel(color: UIColor.groupTableViewBackground)
                print("Сообщение: \(model.message)")
                return cell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 100.0
    }
    
}
