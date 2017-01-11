//
//  ACNewsManagers.swift
//  vk_news
//
//  Created by Gregory House on 05.11.16.
//  Copyright © 2016 vvz. All rights reserved.
//

import Foundation

//MARK: интерфейс и доступ к данным
class ACNewsManager
{
    
    static var newsArray = NSMutableArray()
    
    class func getNumberOfSection () -> Int
    {
        return newsArray.count
    }
    
    class func getNumberOfCells (atSection section: Int) -> Int
    {
        return (newsArray[section] as! [ACNews]).count
    }
    
    class func getCellModel (atSection section: Int, andIndex index: Int) -> ACNews
    {
        return (newsArray[section] as! [ACNews])[index]
    }
    
}

//MARK: загрузка данных из интернета
extension ACNewsManager
{
    class func getMNews (withCount count: Int, success: @escaping () -> Void, failure: @escaping (_ errorCode: Int) -> Void) -> Void
    {
        if newsArray.count == 0
        {
            let newsfeedGetOperation = NewsfeedGetOperation(withCount: count, success: { (modelsArray) in
                
                self.newsArray = NSMutableArray(array: modelsArray)
                success()
                
            }, failure: failure)
            OperationsManager.addOperation(op: newsfeedGetOperation, cancellingQueue: true)
        }
    }
}
