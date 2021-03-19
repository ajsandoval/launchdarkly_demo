//
//  AppDelegate.swift
//  LaunchDarkly_Demo
//
//  Created by Tony Sandoval on 3/17/21.
//

import UIKit
import LaunchDarkly

private let mobileKey = "mob-27bee87c-0e0a-4633-a21a-6d9f6887361d"

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        setUpLDClient()
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
    
    private func setUpLDClient() {
        let user = LDUser(key: "USERID123456879", email: "ajsandoval98@gmail.com")
//        let user = LDUser(key: "USERID123456987", email: "test@gmail.com")
        print("LD Client Setup")

        let config = LDConfig(mobileKey: mobileKey)
        LDClient.start(config: config, user: user, startWaitSeconds: 5) { timedOut in
            if timedOut {
                // The SDK may not have the most recent flags for the configured user
                print("timed out")
            } else {
                // The SDK has received flags for the configured user
                print("timed in")
            }
        }
    }


}

