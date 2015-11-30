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
    
    var userHabits : [Habit] = []
    var user = PFUser.currentUser()!
    var colorsArray = NSArray(ofColorsWithColorScheme:ColorScheme.Analogous, with:UIColor.flatSkyBlueColor(), flatScheme:true) as! [UIColor]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.tableView.backgroundColor = UIColor.flatYellowColor()
        self.tableView.separatorColor = UIColor.flatYellowColor().darkenByPercentage(0.05)
    }

    override func viewDidAppear(animated: Bool) {
        self.userHabits = Habit.getHabitsForCurrentUser()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.userHabits.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
        cell.backgroundColor = UIColor.flatYellowColor()
        cell.textLabel?.text = self.userHabits[indexPath.row].title
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let habit = self.userHabits[indexPath.row]
        let detailController = HabitDetailViewController()
        detailController.habit = habit
        detailController.userHabits = self.userHabits
        detailController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(detailController, animated: true)
    }

}
