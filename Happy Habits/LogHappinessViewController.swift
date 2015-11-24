//
//  LogHappinessViewController.swift
//  Happy Habits
//
//  Created by Maggy Hillen on 11/17/15.
//  Copyright © 2015 Maggy Hillen. All rights reserved.
//

import UIKit

class LogHappinessViewController: UIViewController {
    
    @IBOutlet weak var happyLogLabel: UILabel!
    @IBOutlet weak var happyLogSlider: UISlider!
    
    override func viewDidLoad() {
        self.view = NSBundle.mainBundle().loadNibNamed("LogHappiness", owner:self, options:nil)![0] as! UIView
        self.view.backgroundColor = self.view.backgroundColor!.colorWithAlphaComponent(0.5)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func happyLogSliderValueChanged(sender: UISlider) {
        let currentValue = Int(sender.value)
        
        self.happyLogLabel.text = "\(currentValue) / 10"
    }
    
    @IBAction func saveTapped(sender: AnyObject) {
        let user = PFUser.currentUser()!
        var userHappinessLog = user["HappinessLog"] as! [Log]
        let currentHappiness = Int(self.happyLogSlider.value)
        userHappinessLog.append(Log(happinessLevel: currentHappiness))
        user["HappinessLog"] = userHappinessLog
        user.saveEventually()
        (self.parentViewController as! ViewController).removeHappyLog(self)
    }
}
