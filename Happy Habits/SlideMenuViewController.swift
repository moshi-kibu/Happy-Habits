//
//  SlideMenuViewController.swift
//  Happy Habits
//
//  Created by Maggy Hillen on 11/27/15.
//  Copyright © 2015 Maggy Hillen. All rights reserved.
//


class SlideMenuViewController:  ENSideMenuNavigationController, ENSideMenuDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sideMenu = ENSideMenu(sourceView: self.view, menuViewController: MenuTableViewController(), menuPosition:.Right)
        sideMenu?.menuWidth = 130.0
        view.bringSubviewToFront(navigationBar)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //    // MARK: - ENSideMenu Delegate Methods
    //    func sideMenuWillOpen() {
    //        print("sideMenuWillOpen")
    //    }
    //
    //    func sideMenuWillClose() {
    //        print("sideMenuWillClose")
    //    }
    //
    //    func sideMenuDidClose() {
    //        print("sideMenuDidClose")
    //    }
    //
    //    func sideMenuDidOpen() {
    //        print("sideMenuDidOpen")
    //    }

    
}

