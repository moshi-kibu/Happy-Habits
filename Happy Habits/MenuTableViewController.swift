//
//  MenuTableViewController.swift
//  Happy Habits
//
//  Created by Maggy Hillen on 11/27/15.
//  Copyright © 2015 Maggy Hillen. All rights reserved.
//

import UIKit

class MenuTableViewController: UITableViewController {
    
    var selectedMenuItem : Int = 0
    let menuOptionTitles = ["Account", "Sign out"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configureView() {
        tableView.contentInset = UIEdgeInsetsMake(64.0, 0, 0, 0) //
        tableView.separatorStyle = .None
        tableView.backgroundColor = UIColor.blackColor()
        tableView.scrollsToTop = false
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return self.menuOptionTitles.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("cell")
        if (cell == nil) {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cell")
            cell!.backgroundColor = UIColor.blackColor()
            cell!.textLabel?.textColor = UIColor.whiteColor()
            //            let selectedBackgroundView = UIView(frame: CGRectMake(0, 0, cell!.frame.size.width, cell!.frame.size.height))
            //            selectedBackgroundView.backgroundColor = UIColor.grayColor().colorWithAlphaComponent(0.2)
            //            cell!.selectedBackgroundView = selectedBackgroundView
        }
        cell!.textLabel?.text = self.menuOptionTitles[indexPath.row]
        return cell!
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50.0
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        switch self.menuOptionTitles[indexPath.row] {
        case "Account":
            //do nothing for now
            break
            
        case "Sign out":
            self.logOutUser()
            break
            
        default:
            break
        }
    }
    
    // MARK: - Menu Functions
    
    func logOutUser() {
        PFUser.logOut()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateInitialViewController()
        self.presentViewController(vc!, animated: false, completion: nil)
    }
    
    
}
