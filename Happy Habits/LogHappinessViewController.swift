//
//  LogHappinessViewController.swift
//  Happy Habits
//
//  Created by Maggy Hillen on 11/17/15.
//  Copyright © 2015 Maggy Hillen. All rights reserved.
//
import Parse
import UIKit
import QuartzCore
import Popover

class LogHappinessViewController: UIViewController {
    
    @IBOutlet weak var happyLogLabel: UILabel!
    @IBOutlet weak var happyLogSlider: UISlider!
    @IBOutlet weak var saveButton: UIButton!
    var popover = Popover()
    var timer = NSTimer()
    
    override func viewDidLoad() {
        self.view = NSBundle.mainBundle().loadNibNamed("LogHappiness", owner:self, options:nil)![0] as! UIView
        self.view.backgroundColor = self.view.backgroundColor!.colorWithAlphaComponent(0.5)
        happyLogSlider.continuous = true
        saveButton.layer.cornerRadius = 5
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
        let currentHappiness = Int(self.happyLogSlider.value)
        userLogs.append(Log(happinessLevel: currentHappiness))
        user["HappinessLog"] = userLogs
        user.saveEventually()
        if userLogs.count >= 1 {
          self.showPopoverNotification()
        } else {
           (self.parentViewController as! ViewController).removeHappyLog(self)
        }
    }
    
    func showPopoverNotification() {
        let width = self.view.frame.width * 0.65
        let height = self.view.frame.height * 0.65
        let aView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        let textLabel = UITextView(frame: aView.bounds)
        textLabel.center = aView.center
        textLabel.textAlignment = .Center
        textLabel.text = "Check back tomorrow to log your happiness again! \n \n You can log it every 24 hours."
        textLabel.textColor = UIColor.whiteColor()
        
        textLabel.backgroundColor = UIColor.flatBlueColor()
        textLabel.font = loraFont
        aView.addSubview(textLabel)
        let options = [
            .Type(.Up)
            ] as [PopoverOption]
        popover = Popover(options: options, showHandler: nil, dismissHandler: self.dismissPopOverNotification)
        popover.show(aView, fromView: self.saveButton, inView: self.view)
        timer = NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: Selector("dismissPopOverNotification"), userInfo: nil, repeats: false)
    }
    
    func dismissPopOverNotification() {
            timer.invalidate()
        if popover.isTopViewInWindow() {
            popover.dismiss()
        }
        if self.view.isTopViewInWindow() {
            (self.parentViewController as! ViewController).removeHappyLog(self)
        }
        
    }
    
}
