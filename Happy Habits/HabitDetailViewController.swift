//
//  HabitDetailViewController.swift
//  Happy Habits
//
//  Created by Maggy Hillen on 11/25/15.
//  Copyright © 2015 Maggy Hillen. All rights reserved.
//

import UIKit
import Parse
import QuartzCore

class HabitDetailViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var habitButton: UIButton!
    @IBOutlet weak var studyButton: UIButton!
    
    var habit : Habit = Habit()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = habit.title
        setTextView()
        habitButton.layer.cornerRadius = 5
        studyButton.layer.cornerRadius = 5
        
        if userHabits.contains(habit) {
            habitButton.setTitle("Drop Habit", forState: UIControlState.Normal)
        }
        
    }
    
    override func viewDidAppear(animated: Bool) {
        if userHabits.contains(habit) {
            habitButton.setTitle("Drop Habit", forState: UIControlState.Normal)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func habitButtonTapped(sender: AnyObject) {
        if habitButton.titleLabel?.text == "Adopt Habit" {
            userHabits.append(habit)
            PFUser.currentUser()!["Habits"] = userHabits
            PFUser.currentUser()!.saveInBackground()
            habitButton.setTitle("Drop Habit", forState: UIControlState.Normal)
        } else {
            userHabits = userHabits.filter({$0 != habit})
            PFUser.currentUser()!["Habits"] = userHabits
            PFUser.currentUser()!.saveInBackground()
            habitButton.setTitle("Adopt Habit", forState: UIControlState.Normal)
        }
    }
    
    
    @IBAction func seeStudyButtonTapped(sender: AnyObject) {
        for view in holderView.subviews {
            view.removeFromSuperview()
        }
        if studyButton.titleLabel?.text == "See Study" {
            setWebView()
            studyButton.setTitle("Hide Study", forState: UIControlState.Normal)
        } else {
            setTextView()
            studyButton.setTitle("See Study", forState: UIControlState.Normal)
        }
    }
    
    func setTextView() {
        webView.hidden = true
        let textView = UITextView()
        textView.text = habit.details
        textView.font = loraFont.fontWithSize(15)
        textView.frame = holderView.bounds
        textView.autoresizingMask.insert(UIViewAutoresizing.FlexibleWidth)
        textView.autoresizingMask.insert(UIViewAutoresizing.FlexibleHeight)
        holderView.addSubview(textView)
        var color = UIColor()
        switch habit.level {
        case "Simple":
            color = triadicColorsArray[1]
            break
        case "Moderate":
            color = triadicColorsArray[2]
            break
        case "Challenging":
            color = triadicColorsArray[3]
            break
        default:
            break
        }
        textView.backgroundColor = color
    }
    
    func setWebView() {
        webView.hidden = false
        let url = NSURL(string: habit.studyURL)
        let request = NSURLRequest(URL: url!)
        webView.loadRequest(request)
    }

}
