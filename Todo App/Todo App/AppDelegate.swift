//
//  AppDelegate.swift
//  Todo App
//
//  Created by Thành Ngô Văn on 09/12/2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        self.window = UIWindow(frame: UIScreen.main.bounds)
        let tabbar = AppTabbar(nibName: AppTabbar.nibName, bundle: nil)
        self.window?.rootViewController = tabbar
        self.window?.overrideUserInterfaceStyle = .dark
        self.window?.makeKeyAndVisible()
        
        return true
    }

}

