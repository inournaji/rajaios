//
//  AppDelegate.swift
//  RajaTec
//
//  Created by Ammar Arangy on 10/25/17.
//  Copyright © 2017 RajaTec. All rights reserved.
//

import UIKit
import OneSignal
import SwiftEventBus

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        
        self.handleLanguage()
        
        self.configureOneSignal(launchOptions: launchOptions)
        
        return true
        
    }
    
    func handleLanguage() {
        
        let languageFlag = UserDefaults().integer(forKey: "LanguageFlag")
        
        if languageFlag == 0  || languageFlag == 1 {
            
            BundleLocalization.sharedInstance().language = "en"
            
        } else if languageFlag == 2 {
            
            BundleLocalization.sharedInstance().language = "ar"
            
        }
        
    }
    
    func configureOneSignal(launchOptions: [UIApplicationLaunchOptionsKey: Any]?) {
        
        let onesignalInitSettings = [kOSSettingsKeyAutoPrompt: false]
        
        // Replace 'YOUR_APP_ID' with your OneSignal App ID.
        OneSignal.initWithLaunchOptions(launchOptions,
                                        appId: "6275d962-4226-4768-ad73-150978fd73dd",
                                        handleNotificationAction: nil,
                                        settings: onesignalInitSettings)
        
        OneSignal.inFocusDisplayType = OSNotificationDisplayType.none
        
        // Recommend moving the below line to prompt for push after informing the user about
        //   how your app will use them.
        OneSignal.promptForPushNotifications(userResponse: { accepted in
            print("User accepted notifications: \(accepted)")
        })
        
    }
    
    func application(_ application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let tokenParts = deviceToken.map { data -> String in
            return String(format: "%02.2hhx", data)
        }
        
        let token = tokenParts.joined()
        print("Device Token: \(token)")
    }
    
    func application(_ application: UIApplication,
                     didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register: \(error)")
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        if UIApplication.shared.applicationState == .active {
        
            OneSignalModel.handleOneSignalNotification(userInfo: userInfo)
            
            OneSignalModel.showAlertViewMessage()
            
        } else {
            
            OneSignalModel.handleOneSignalNotificationWhenAppKilled(userInfo: userInfo)
            
            SwiftEventBus.post(Events.goToOfferScreen.rawValue)
            
        }
        
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

