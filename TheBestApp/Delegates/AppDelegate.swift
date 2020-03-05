//
//  AppDelegate.swift
//  TheBestApp
//
//  Created by Zachary Pinto on 3/3/20.
//  Copyright © 2020 Zachary Pinto. All rights reserved.
//

import UIKit
import Parse

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    func infoForKey(_ key: String) -> String? {
           return (Bundle.main.infoDictionary?[key] as? String)?
               .replacingOccurrences(of: "\\", with: "")
    }


    // Initialize Parse
    // Set applicationId and server based on the values in the Heroku settings.
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        
        Parse.initialize(
               with: ParseClientConfiguration(block: { (configuration: ParseMutableClientConfiguration) -> Void in
                print(self.infoForKey("PARSE_APP_ID")!)
                print(self.infoForKey("PARSE_API_SERVER")!)
                
                configuration.applicationId = self.infoForKey("PARSE_APP_ID")!
                configuration.clientKey = self.infoForKey("PARSE_MASTER_KEY")
                configuration.server = self.infoForKey("PARSE_API_SERVER")!
               })
           )
        
      
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

