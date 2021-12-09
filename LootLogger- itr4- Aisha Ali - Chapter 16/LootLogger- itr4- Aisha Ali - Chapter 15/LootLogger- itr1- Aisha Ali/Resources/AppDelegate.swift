//
//  AppDelegate.swift
//  LootLogger- itr1- Aisha Ali
//
//  Created by Aisha Ali on 11/14/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    UIButton.appearance().tintColor = UIColor(
      red: (255/255.0),
      green: (88/255.0),
      blue: (41/255.0),
      alpha: 1.0)
    
//    UINavigationItem.appearance().tintColor = UIColor(
//
//      red: (255/255.0),
//      green: (88/255.0),
//      blue: (41/255.0),
//      alpha: 1.0)
//    navigationController?.navigationBar.barTintColor = UIColor.green

    // Override point for customization after application launch.
    return true
  }

  // MARK: UISceneSession Lifecycle

  func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
  }

  func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
  }


}

