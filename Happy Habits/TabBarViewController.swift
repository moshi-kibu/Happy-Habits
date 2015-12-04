//
//  TabBarViewController.swift
//  Happy Habits
//
//  Created by Maggy Hillen on 11/30/15.
//  Copyright © 2015 Maggy Hillen. All rights reserved.
//

import UIKit
import QuartzCore

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.barTintColor = UIColor.flatSkyBlueColor()
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.whiteColor(), NSFontAttributeName:loraFont.fontWithSize(10)], forState:.Normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.flatBlueColor(), NSFontAttributeName:loraFont.fontWithSize(10)], forState:.Selected)
        
        for viewController in viewControllers! {
            let item = viewController.tabBarItem
            if let image = item.image {
                item.image = image.imageWithColor(UIColor.whiteColor()).imageWithRenderingMode(.AlwaysOriginal)
                item.selectedImage = image.imageWithColor(UIColor.flatBlueColor()).imageWithRenderingMode(.AlwaysOriginal)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
