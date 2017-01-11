//
//  AccountGetOperation.swift
//  vk_news
//
//  Created by Gregory House on 02.01.17.
//  Copyright © 2017 vvz. All rights reserved.
//

import Foundation

class AccountGetOperation: Operation
{
    var success: (NSArray) -> Void
    var failure: (Int) -> Void
    
    var internetTask: URLSessionDataTask?
    
    init(success: @escaping (NSArray) -> Void, failure: @escaping (Int) -> Void)
    {
        self.success = success
        self.failure = failure
    }
    
    override func cancel()
    {
        internetTask?.cancel()
    }
    
    override func main()
    {
        let semaphore = DispatchSemaphore(value: 0)
        
        internetTask = API_WRAPPER.getAccountInfo(successBlock: { (<#JSON#>) in
            
            
            
            
            
            if (self.isCancelled)
            {
                self.success(NSArray())
            }
            else
            {
                self.success(NSArray()) //конечный массив из парсинга передается тут
            }
            
            semaphore.signal()
            
        }, failureBlock: { (errorCode) in
            
            self.failure(errorCode)
            semaphore.signal()
            
        })
        
        _ = semaphore.wait(timeout: DispatchTime.distantFuture)
        
    
    }
    
    
}
