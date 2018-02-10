//
//  AppDelegate.swift
//  infoquesttrial
//
//  Created by rohit on 19/01/17.
//  Copyright © 2017 rohit. All rights reserved.
//

import UIKit
import SwiftyJSON
import GoogleMaps
import GooglePlaces
import OneSignal
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var defaults = UserDefaults.standard
    let appid = "03afb560-e16d-4125-affa-a1b8a1c39cd0"
    


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        OneSignal.initWithLaunchOptions(launchOptions, appId: appid, handleNotificationReceived: { (notification) in
            
        }, handleNotificationAction: { (result) in
            self.window?.rootViewController = self.window?.rootViewController?.storyboard?.instantiateViewController(withIdentifier: "user")
            
           
            
            
            let payload: OSNotificationPayload? = result?.notification.payload
            
            var fullMessage: String? = payload?.body
            if payload?.additionalData != nil {
                var additionalData: [AnyHashable: Any]? = payload?.additionalData
                
                
                if additionalData!["actionSelected"] != nil {
                    fullMessage = fullMessage! + "\nPressed ButtonId:\(additionalData!["actionSelected"])"
                }
            }
            
        }, settings: [kOSSettingsKeyAutoPrompt : true])
        GMSServices.provideAPIKey("AIzaSyAUaZNl9WlwEe-kJQO9gL7tePczRqsPrBw")
        GMSPlacesClient.provideAPIKey("AIzaSyAUaZNl9WlwEe-kJQO9gL7tePczRqsPrBw")
        
        if defaults.value(forKey: "Key") != nil {
            
            window?.rootViewController = window?.rootViewController?.storyboard?.instantiateViewController(withIdentifier: "user")
            
            
        }else {
            
             window?.rootViewController = window?.rootViewController?.storyboard?.instantiateViewController(withIdentifier: "login")
            
        }
        
                return true
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

