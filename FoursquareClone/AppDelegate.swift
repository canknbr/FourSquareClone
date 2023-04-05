//
//  AppDelegate.swift
//  FoursquareClone
//
//  Created by Can Kanbur on 4.04.2023.
//

import UIKit
import Parse
@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let config = ParseClientConfiguration { ParseMutableClientConfiguration in
            ParseMutableClientConfiguration.applicationId = "1S2Gi8UOPYCer09lCbgkfFFI9mbEVaRkCzZyjznd"
            ParseMutableClientConfiguration.clientKey = "5xXJrp4YWBxO5diDJTQro7wux8kAcwb5m3gLgX45"
            ParseMutableClientConfiguration.server = "https://parseapi.back4app.com/"
            
        }
        Parse.initialize(with: config)
        
        
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

