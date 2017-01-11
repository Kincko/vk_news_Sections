//
//  OperationManager.swift
//  vk_news
//
//  Created by Gregory House on 25.12.16.
//  Copyright © 2016 vvz. All rights reserved.
//

import Foundation

class OperationsManager
{
    private static var serviceOperationsQueue = OperationQueue ()

    class func addOperation (op: Operation, cancellingQueue flag: Bool)
    {
        
        serviceOperationsQueue.maxConcurrentOperationCount = 1
        
        if (flag)
        {
            serviceOperationsQueue.cancelAllOperations()
        }
        
        serviceOperationsQueue.addOperation (op)
        
    }
}
