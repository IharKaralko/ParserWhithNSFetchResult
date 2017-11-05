//
//  AppDelegate.swift
//  MyXMLParserDemo
//
//  Created by Ihar Karalko on 7/4/17.
//  Copyright © 2017 Ihar Karalko. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    self.window = UIWindow(frame: UIScreen.main.bounds)
    let nc = UINavigationController()
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let vc = storyboard.instantiateViewController(withIdentifier: "tvc") as! TableViewController
    nc.viewControllers = [vc]
    self.window?.rootViewController = nc
    self.window?.makeKeyAndVisible()
    nc.hidesBarsOnSwipe = true
    UINavigationBar.appearance().barTintColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
    UINavigationBar.appearance().tintColor = .white
    if let barFont = UIFont(name: "AppleSDGothicNeo-Light", size: 24){
      UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: barFont]
    }
    self.load()
    return true
  }

  func applicationWillTerminate(_ application: UIApplication) {
    CoreDataStack.stack.saveContext()
  }
  
//  func applicationWillEnterForeground(_ application: UIApplication) {
//    self.load()
//  }
  
}

private extension AppDelegate {
  
  func load() {
         Parser.manager.getFeeds(callback: { results in
        if let feeds = results {
          CoreDataStack.stack.saveInBackground(feeds: feeds)
        }
      })
   
  }
  
}

