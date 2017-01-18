//
//  ACAccountManager.swift
//  vk_news
//
//  Created by Gregory House on 24.11.16.
//  Copyright © 2016 vvz. All rights reserved.
//

import Foundation

class ACAccountManager
{
    static var accountInfo = NSMutableArray()
    static var accountWall = NSMutableArray()
    static var accountItems = NSMutableArray()
    
    class func getNumberOfSections () -> Int
    {
        return accountItems.count
    }
    
    class func getNumberOfCells (atSection section: Int) -> Int
    {
        let section = accountItems[section] as! ACWallPost
        return section.content.count
    }
    
    class func getCellModel (atIndex index: Int) -> ACWallPost
    {
        return accountItems[index] as! ACWallPost
    }
}

//MARK: загрузка данных пользователя и элементов стены
extension ACAccountManager
{
    class func getAccountItems (success_info: @escaping () -> Void, success_wall: @escaping () -> Void, failure: @escaping (_ errorCode: Int) -> Void) -> Void
    {
        
        if accountItems.count == 0
        {
            
            let getAccountInfoOperation = GetAccountInfoOperation(success: { (modelArray) in
                
                self.accountInfo = NSMutableArray(array: modelArray)
                success_info()
                
            }, failure: failure)
            
            let getWallOperation = GetWallOperation(success: { (modelArray) in
                
                self.accountWall = NSMutableArray(array: modelArray)
                
                accountItems = accountInfo
                
                for i in 0..<accountWall.count
                {
                    accountItems.add(accountWall[i])
                }

                success_wall()
                
            }, failure: failure)
            
            OperationsManager.addOperation(op: getAccountInfoOperation, cancellingQueue: true)
            OperationsManager.addOperation(op: getWallOperation, cancellingQueue: true)
            
        }
    }
}
