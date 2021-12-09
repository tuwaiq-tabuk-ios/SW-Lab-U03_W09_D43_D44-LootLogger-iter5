//
//  SceneDelegate.swift
//  LootLogger
//
//  Created by Ahlam on 09/04/1443 AH.
//

import UIKit


class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  
  var window: UIWindow?
  
  
  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    print(#function)
    // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
    // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
    // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
    guard let _ = (scene as? UIWindowScene) else { return }
    
    // Create an ImageStore
      let imageStore = ImageStore()
    
    let itemStore = ItemStore()
    // Access the ItemsViewController and set its item store
    let navController = window!.rootViewController as! UINavigationController
    let itemsController = navController.topViewController as! ItemsViewController
    
    itemsController.itemStore = itemStore
    // Create an ImageStore
    itemsController.imageStore = imageStore
  }
  
  func sceneWillResignActive(_ scene: UIScene) {
    print(#function)
  }
  func sceneDidEnterBackground(_ scene: UIScene) {
    print(#function)
  }
  func sceneWillEnterForeground(_ scene: UIScene) {
    print(#function)
  }
  func sceneDidBecomeActive(_ scene: UIScene) {
    print(#function)
  }
  func sceneDidDisconnect(_ scene: UIScene) {
    // Called as the scene is being released by the system.
    // This occurs shortly after the scene enters the background, or when its session is discarded.
    // Release any resources associated with this scene that can be re-created the next time the scene connects.
    // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
  }
  
  
}

