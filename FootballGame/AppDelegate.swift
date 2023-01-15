//
//  AppDelegate.swift
//  FootballGame
//
//  Created by Nishio Naoki on 2022/12/22.
//

import UIKit
import GameKit
import GoogleMobileAds

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Show GameCenter AccessPoint
        // Call GameCenter authentication
        GKAccessPoint.shared.location = .topTrailing
        GKAccessPoint.shared.showHighlights = true
        GKAccessPoint.shared.isActive = true
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = UIViewController()
        if let _ = window.rootViewController {
            print("GameCenterのログイン処理を呼び出します")
            GameCenterHelper.loginGameCenter()
        }
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        return true
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    func applicationWillResignActive(_ application: UIApplication) {
        print("------------------------------")
      //        testFlag = true
              
        NotificationCenter.default.post(name: Notification.Name(rawValue:"MyNotification"), object: nil)
              

    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    
    
    
}


struct GameCenterHelper {
    
    static func loginGameCenter() {
        GKLocalPlayer.local.authenticateHandler = { _, error in
            if error != nil {
                print("You are not logged into GameCenter.")
                print(error.debugDescription)
            } else if GKLocalPlayer.local.isAuthenticated {
                print("You are logged into GameCenter.")
            }
        }
    }
}

