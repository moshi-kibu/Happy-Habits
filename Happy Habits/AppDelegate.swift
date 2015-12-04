//
//  AppDelegate.swift
//  Happy Habits
//
//  Created by Maggy Hillen on 11/17/15.
//  Copyright © 2015 Maggy Hillen. All rights reserved.
//

import UIKit
import Parse
import ParseFacebookUtilsV4
import ParseTwitterUtils
import QuartzCore
import ChameleonFramework

var userHabits : [Habit] = []
var userLogs : [Log] = []
var loraFont : UIFont = UIFont()
var colorsArray = NSArray(ofColorsWithColorScheme:ColorScheme.Triadic, with:UIColor.flatMintColor(), flatScheme:true) as! [UIColor]

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        Chameleon.setGlobalThemeUsingPrimaryColor(UIColor.flatSkyBlueColor(), withContentStyle: UIContentStyle.Contrast)
        
        Parse.enableLocalDatastore()
        Habit.registerSubclass()
        Log.registerSubclass()
        
        
        // Initialize Parse.
        Parse.setApplicationId(parseApplicationID,
            clientKey: parseClientKey)
        
        PFTwitterUtils.initializeWithConsumerKey(twitterConsumerKey, consumerSecret: twitterConsumerSecret)
        
        PFFacebookUtils.initializeFacebookWithApplicationLaunchOptions(launchOptions);
        
        // [Optional] Track statistics around application opens.
        PFAnalytics.trackAppOpenedWithLaunchOptions(launchOptions)
        
        loraFont = UIFont(name: "Lora-Regular", size: 15)!
        self.getInitialData()
        
        
        return true
    }
    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        return FBSDKApplicationDelegate.sharedInstance().application(application, openURL: url, sourceApplication: sourceApplication, annotation: annotation)
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        FBSDKAppEvents.activateApp()
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func getInitialData() {
        dispatch_async(dispatch_get_main_queue()) {
            Quote.getAllQuotes()
            Habit.getAllHabits()
            if PFUser.currentUser()?.isAuthenticated() == true {
                userHabits = Habit.getHabitsForCurrentUser()
                userLogs = Log.findLogsForCurrentUser()
            }
        }
    }


}

