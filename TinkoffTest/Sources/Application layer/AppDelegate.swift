//
//  AppDelegate.swift
//  TinkoffTest
//
//  Created by Ilya Kharabet on 13.07.17.
//  Copyright © 2017 IK. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        AppearanceManager.applyTheme()
        
        if let newsView = (window?.rootViewController as? UINavigationController)?.topViewController as? NewsView {
            NewsAssembly.assembly(with: newsView)
        }
        
        return true
    }

}

