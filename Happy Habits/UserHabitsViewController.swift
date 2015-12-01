//
//  UserHabitsViewController.swift
//  Happy Habits
//
//  Created by Maggy Hillen on 11/27/15.
//  Copyright © 2015 Maggy Hillen. All rights reserved.
//

import UIKit
import Parse
import QuartzCore
import ChameleonFramework

class UserHabitsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var user = PFUser.currentUser()!
    var colorsArray = NSArray(ofColorsWithColorScheme:ColorScheme.Analogous, with:UIColor.flatSkyBlueColor(), flatScheme:true) as! [UIColor]
    
    override func viewDidLoad() {
        if userHabits == [] {
            userHabits = Habit.getHabitsForCurrentUser()
        }
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.tableView.backgroundColor = UIColor.flatYellowColor()
        self.tableView.separatorColor = UIColor.flatYellowColor().darkenByPercentage(0.05)
        self.tableView.registerNib(UINib(nibName: "UserHabitsTableHeader", bundle: nil), forCellReuseIdentifier: "TableHeader")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = self.tableView.dequeueReusableCellWithIdentifier("TableHeader") as! UserHabitsTableHeader
        header.backgroundColor = UIColor.flatOrangeColor()
        header.label.font = loraFont.fontWithSize(18)
        return header
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userHabits.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
        cell.backgroundColor = UIColor.flatYellowColor()
        cell.textLabel?.text = userHabits[indexPath.row].title
        cell.textLabel?.font = loraFont.fontWithSize(16)
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let habit = userHabits[indexPath.row]
        let detailController = HabitDetailViewController()
        detailController.habit = habit
        detailController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(detailController, animated: true)
    }

}
