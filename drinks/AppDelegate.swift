//
//  AppDelegate.swift
//  coctails
//
//  Created by Macbook Air on 10.09.2020.
//  Copyright © 2020 macbook. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow()
        window?.makeKeyAndVisible()
        window?.rootViewController = UINavigationController(rootViewController: DrinksViewController())
        
        setAppearance()
        
        return true
    }
    
    func setAppearance() {
        let attributes = [NSAttributedString.Key.font: UIFont.robotoMedium(ofSize: 24)!]
        UINavigationBar.appearance().titleTextAttributes = attributes
        UINavigationBar.appearance().barTintColor = UIColor.systemBackground
        UINavigationBar.appearance().isTranslucent = false
    }

}
