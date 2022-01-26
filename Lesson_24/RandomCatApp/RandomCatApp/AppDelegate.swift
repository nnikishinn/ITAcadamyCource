//
//  AppDelegate.swift
//  RandomCatApp
//
//  Created by Александр Савков on 21.01.22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let rootViewController = ViewController()
        let navigationController = UINavigationController(rootViewController: rootViewController)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        return true
    }
}
