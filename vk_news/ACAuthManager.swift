//
//  ACAuthManager.swift
//  vk_news
//
//  Created by MacAdmin on 29.10.16.
//  Copyright © 2016 vvz. All rights reserved.
//

import UIKit
import VK_ios_sdk

class ACAuthManager : NSObject
{
    static let sharedInstance = ACAuthManager()
    //singletone
    
    var successBlock : ( ()-> Void )?
    var failureBlock : ( ()-> Void )?
    weak var controller : UIViewController?
    
    var sdkInstance : VKSdk!
}

//MARK: - работа с URL - схемой VK SDK
extension ACAuthManager
{
    func processOpenURL ( url : URL , fromApplication sourceApplication : String? ) -> Bool
    {
        return VKSdk.processOpen( url , fromApplication : sourceApplication )
    }
}

//MARK: - логин и авторизация - открытый интерфейс
extension ACAuthManager
{
    func login ( withUnderlayController controller : UIViewController , success : @escaping () -> Void , failure : @escaping () -> Void )
    {
        if ( getAccessToken() != "" )
        {
            success()
            return
        }
        
        self.controller = controller
        self.successBlock = success
        self.failureBlock = failure
        
        sdkInstance = VKSdk.initialize(withAppId: "5684635")
        sdkInstance.register(self)
        sdkInstance.uiDelegate = self
        
        VKSdk.authorize(["friends" , "photos" , "audio" , "video" , "messages" , "wall" , "offline"])
    }
}

//MARK: - реализация процедур протоколов VKSDKDelegate , VKSDKUiDelegate
extension ACAuthManager : VKSdkDelegate , VKSdkUIDelegate
{
    func vkSdkUserAuthorizationFailed()
    {
        self.failureBlock?()
    }
    
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!)
    {
        if let accessToken = result.token
        {
            setAccessToken ( token: accessToken.accessToken )
            self.successBlock?()
        }
        else
        {
            self.failureBlock?()
        }
    }
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!)
    {
        
    }
    
    func vkSdkShouldPresent(_ controller: UIViewController!)
    {
        self.controller?.present(controller, animated: true, completion: nil)
    }
    
    private func setAccessToken ( token : String )
    {
        UserDefaults.standard.set(token, forKey: "X-Access-Token")
        UserDefaults.standard.synchronize()
    }
}

//MARK: - внешний доступ к access_token
extension ACAuthManager
{
    func getAccessToken () -> String
    {
        if let token = UserDefaults.standard.object(forKey: "X-Access-Token")
        {
            return token as! String
        }
        
        return ""
    }
}
