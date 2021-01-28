//
//  AppDelegate.swift
//  App
//
//  Created by Максим Шаптала on 27.01.2021.
//

import UIKit

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        window?.rootViewController = UIStoryboard(name: "Splash", bundle: .main).instantiateInitialViewController()
        window?.makeKeyAndVisible()
        return true
    }

}

