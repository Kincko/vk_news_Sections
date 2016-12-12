//
//  API_WRAPPER.swift
//  vk_news
//
//  Created by Gregory House on 02.11.16.
//  Copyright © 2016 vvz. All rights reserved.
//

import Foundation

class API_WRAPPER
{
    class func composeGenericHTTPGetRequest (forBaseURL baseURL: String, andMethod method: String, withParametrs parametrs: NSDictionary) -> NSURLRequest
    {
        var requestString = baseURL + method + "?"
        
        let keysArray = parametrs.allKeys as! [String]
        
        for i in 0..<keysArray.count
        {
            let key = keysArray[i]
            let value = parametrs[key] as! String
            
            if (i < keysArray.count - 1)
            {
                requestString += "\(key)=\(value)&"
            }
            else
            {
                requestString += "\(key)=\(value)"
            }
        }
        
        print("\n\n\n строка запроса - \(requestString)\n\n\n")
        
        let request = NSMutableURLRequest ()
        
        request.httpMethod = "GET"
        request.url = URL(string: requestString)
        
        return request
    }
}

//MARK получение списков постов
extension API_WRAPPER
{
    class func getNews (withCount count: Int, successBlock: @escaping (_ jsonResponce: JSON) -> Void, failureBlock: @escaping (_ errorCode: Int) -> Void)
    {
        let argsDictionary = NSMutableDictionary ()
        
        argsDictionary.setObject("\(count)", forKey: Const.URLConst.Arguments.kCount)
        argsDictionary.setObject("post", forKey: Const.URLConst.Arguments.kFilters)
        argsDictionary.setObject(ACAuthManager.sharedInstance.getAccessToken(), forKey: Const.URLConst.Arguments.kAccessToken)
        
        
        let request = composeGenericHTTPGetRequest(forBaseURL: Const.URLConst.kBaseURL, andMethod: Const.URLConst.Scripts.kMethod, withParametrs: argsDictionary)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
            genericCompletetionCallback(withResponseData: data, response: response, error: error, successBlock: successBlock, failureBlock: failureBlock)
        }
        task.resume()
    }
}

//MARK получение истории сообщений с определнным пользователем
extension API_WRAPPER
{
    class func getChatMessages (withUser user: String, successBlock: @escaping (_ jsonResponce: JSON) -> Void, failureBlock: @escaping (_ errorCode: Int) -> Void)
    {
        let argsDictionary = NSMutableDictionary ()
        
        argsDictionary.setObject("30", forKey: Const.URLConst.Arguments.kCount)
        argsDictionary.setObject("\(user)", forKey: Const.URLConst.Arguments.kUserChat)
        argsDictionary.setObject(ACAuthManager.sharedInstance.getAccessToken(), forKey: Const.URLConst.Arguments.kAccessToken)
        
        
        let request = composeGenericHTTPGetRequest(forBaseURL: Const.URLConst.kBaseURL, andMethod: Const.URLConst.Scripts.kMethodUserChat, withParametrs: argsDictionary)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
            genericCompletetionCallback(withResponseData: data, response: response, error: error, successBlock: successBlock, failureBlock: failureBlock)
        }
        task.resume()
    }
}

//MARK получение списка диалогов
extension API_WRAPPER
{
    class func getDialogs (withCount count: Int, successBlock: @escaping (_ jsonResponce: JSON) -> Void, failureBlock: @escaping (_ errorCode: Int) -> Void)
    {
        let argsDictionary = NSMutableDictionary ()
        
        argsDictionary.setObject("\(count)", forKey: Const.URLConst.Arguments.kCount)
        //argsDictionary.setObject("post", forKey: Const.URLConst.Arguments.kFilters)
        argsDictionary.setObject(ACAuthManager.sharedInstance.getAccessToken(), forKey: Const.URLConst.Arguments.kAccessToken)
        
        let request = composeGenericHTTPGetRequest(forBaseURL: Const.URLConst.kBaseURL, andMethod: Const.URLConst.Scripts.kMethodMessage, withParametrs: argsDictionary)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
            genericCompletetionCallback(withResponseData: data, response: response, error: error, successBlock: successBlock, failureBlock: failureBlock)
        }
        task.resume()
    }
}

//MARK отправка сообщения
extension API_WRAPPER
{
    class func sendMessage (withUser users:String, withMessage text:String, successBlock: @escaping (_ jsonResponce: JSON) -> Void, failureBlock: @escaping (_ errorCode: Int) -> Void)
    {
        let argsDictionary = NSMutableDictionary ()
        
        argsDictionary.setObject("\(users)", forKey: Const.URLConst.Arguments.kUserChat)
        argsDictionary.setObject("\(text)", forKey: Const.URLConst.Arguments.kTextMessage)
        argsDictionary.setObject(ACAuthManager.sharedInstance.getAccessToken(), forKey: Const.URLConst.Arguments.kAccessToken)
        
        let request = composeGenericHTTPGetRequest(forBaseURL: Const.URLConst.kBaseURL, andMethod: Const.URLConst.Scripts.kMethodSendMessage, withParametrs: argsDictionary)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
            genericCompletetionCallback(withResponseData: data, response: response, error: error, successBlock: successBlock, failureBlock: failureBlock)
        }
        task.resume()
    }
}

//MARK LongPoll
extension API_WRAPPER
{
    class func getLongPoll (successBlock: @escaping (_ jsonResponce: JSON) -> Void, failureBlock: @escaping (_ errorCode: Int) -> Void)
    {
        let argsDictionary = NSMutableDictionary ()
        
        argsDictionary.setObject("\(1)", forKey: Const.URLConst.Arguments.kNeedPts)
        argsDictionary.setObject(ACAuthManager.sharedInstance.getAccessToken(), forKey: Const.URLConst.Arguments.kAccessToken)
        
        let request = composeGenericHTTPGetRequest(forBaseURL: Const.URLConst.kBaseURL, andMethod: Const.URLConst.Scripts.kMethodLongPollServer, withParametrs: argsDictionary)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
            genericCompletetionCallback(withResponseData: data, response: response, error: error, successBlock: successBlock, failureBlock: failureBlock)
        }
        task.resume()
    }
}


extension API_WRAPPER
{
    class func getRequest(withKey key:String, withServer server:String, withTs ts:String, successBlock: @escaping (_ jsonResponce: JSON) -> Void, failureBlock: @escaping (_ errorCode: Int) -> Void)
    {
        var requestString = "https://\(server)?act=a_check&key=\(key)&ts=\(ts)&wait=25&mode=2&version=1"
        print("Запрос 2 \(requestString)")
        let request = NSMutableURLRequest ()
        
        request.httpMethod = "GET"
        request.url = URL(string: requestString)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
            genericCompletetionCallback(withResponseData: data, response: response, error: error, successBlock: successBlock, failureBlock: failureBlock)
        }
        task.resume()
    }
}

//MARK получение данных пользователей
extension API_WRAPPER
{
    class func getUsers (withUsers users:[String], successBlock: @escaping (_ jsonResponce: JSON) -> Void, failureBlock: @escaping (_ errorCode: Int) -> Void)
    {
        let argsDictionary = NSMutableDictionary ()
        
        var allUser = ""
        
        for i in 0..<users.count
        {
            let user = users[i]
            if (i < users.count - 1)
            {
                allUser += "\(user),"
            }
            else
            {
                allUser += "\(user)"
            }
        }
        
        argsDictionary.setObject("\(allUser)", forKey: Const.URLConst.Arguments.kUser)
        //argsDictionary.setObject("post", forKey: Const.URLConst.Arguments.kFilters)
        argsDictionary.setObject("photo_100", forKey: Const.URLConst.Arguments.kFields)
        
        let request = composeGenericHTTPGetRequest(forBaseURL: Const.URLConst.kBaseURL, andMethod: Const.URLConst.Scripts.kMethodUser, withParametrs: argsDictionary)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
            genericCompletetionCallback(withResponseData: data, response: response, error: error, successBlock: successBlock, failureBlock: failureBlock)
        }
        task.resume()
    }
}



//MARK: общий обработчик ответов
extension API_WRAPPER
{
    class func genericCompletetionCallback (withResponseData data: Data?, response: URLResponse?, error: Error?, successBlock: (_ jsonResponse: JSON) -> Void, failureBlock: (_ errorCode: Int) -> Void)
    {
        if (error != nil)
        {
            failureBlock((error as! NSError).code)
        }
        
        if (data != nil)
        {
            do
            {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                let swiftyJSON = JSON(json)
                print("\n\n ответ - \(swiftyJSON)\n\n ")
                successBlock(swiftyJSON)
            }
            catch
            {
                failureBlock(-80)
            }
        }
        else
        {
            failureBlock(-80)
        }
    }
}
