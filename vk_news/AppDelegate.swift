//
//  AppDelegate.swift
//  vk_news
//
//  Created by Gregory House on 25.10.16.
//  Copyright © 2016 vvz. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate
{
    var window: UIWindow?

    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool
    {
        return ACAuthManager.sharedInstance.processOpenURL(url: url, fromApplication: sourceApplication)
    }
}

