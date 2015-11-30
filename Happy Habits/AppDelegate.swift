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

extension UIImage {
    func imageWithColor(tintColor: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        
        let context = UIGraphicsGetCurrentContext()! as CGContextRef
        CGContextTranslateCTM(context, 0, self.size.height)
        CGContextScaleCTM(context, 1.0, -1.0);
        CGContextSetBlendMode(context, CGBlendMode.Normal)
        
        let rect = CGRectMake(0, 0, self.size.width, self.size.height) as CGRect
        CGContextClipToMask(context, rect, self.CGImage)
        tintColor.setFill()
        CGContextFillRect(context, rect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext() as UIImage
        UIGraphicsEndImageContext()
        
        return newImage
    }
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        Parse.enableLocalDatastore()
        Habit.registerSubclass()
        Log.registerSubclass()
        
        
        // Initialize Parse.
        Parse.setApplicationId("bRwQbVWCtAi7zPsYoCM4VnM5sh1soYGWDPinprsO",
            clientKey: "mQkhiskXv4v2GevAmj3kYG2bYg7ocOeKp31wd08l")
        
        PFTwitterUtils.initializeWithConsumerKey("xAdcmuHjvDFV6JuJUhrWzaWGN", consumerSecret:"j9AXr6yvjwtLvu2z0dWVwOzgrrJoZkqW6Qc9VYwdldjHQfsuk6")
        
        PFFacebookUtils.initializeFacebookWithApplicationLaunchOptions(launchOptions);
        
        // [Optional] Track statistics around application opens.
        PFAnalytics.trackAppOpenedWithLaunchOptions(launchOptions)
        
        
        self.getInitialData()
        
        Chameleon.setGlobalThemeUsingPrimaryColor(UIColor.flatSkyBlueColor(), withContentStyle: UIContentStyle.Contrast)
        self.setTabBarAppearance()


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
    
    func setTabBarAppearance() {
        UITabBar.appearance().barTintColor = UIColor.flatSkyBlueColor()
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.whiteColor()], forState:.Normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.flatBlueColor()], forState:.Selected)
        
        let tabBarController = self.window?.rootViewController as! UITabBarController
        
        for viewController in tabBarController.viewControllers! {
            let item = viewController.tabBarItem
            if let image = item.image {
                item.image = image.imageWithColor(UIColor.whiteColor()).imageWithRenderingMode(.AlwaysOriginal)
                item.selectedImage = image.imageWithColor(UIColor.flatBlueColor()).imageWithRenderingMode(.AlwaysOriginal)
            }
        }
    }
    
    func getInitialData() {
        let tabBarController = self.window?.rootViewController as! UITabBarController
        let navigationViewController = tabBarController.viewControllers![0] as! UINavigationController
        let initialViewController = navigationViewController.viewControllers[0] as! ViewController

        dispatch_async(dispatch_get_main_queue()) {
            if PFUser.currentUser()?.isAuthenticated() == true {
                initialViewController.userhabits = Habit.getHabitsForCurrentUser()
                initialViewController.logs = Log.findLogsForCurrentUser()
            }
        }
    }


}

