//
//  HabitDetailViewController.swift
//  Happy Habits
//
//  Created by Maggy Hillen on 11/25/15.
//  Copyright © 2015 Maggy Hillen. All rights reserved.
//

import UIKit

class HabitDetailViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var habitButton: UIButton!
    @IBOutlet weak var studyButton: UIButton!
    
    var habit : Habit = Habit()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = self.habit.title
        self.setTextView()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func seeStudyButtonTapped(sender: AnyObject) {
        for view in self.holderView.subviews {
            view.removeFromSuperview()
        }
        if self.studyButton.titleLabel?.text == "See Study" {
            self.setWebView()
            self.studyButton.setTitle("Hide Study", forState: UIControlState.Normal)
        } else {
            self.setTextView()
            self.studyButton.setTitle("See Study", forState: UIControlState.Normal)
        }
    }
    
    func setTextView() {
        self.webView.hidden = true
        let textView = UITextView()
        textView.backgroundColor = UIColor.yellowColor()
        textView.text = self.habit.details
        textView.frame = holderView.bounds
        textView.autoresizingMask.insert(UIViewAutoresizing.FlexibleWidth)
        textView.autoresizingMask.insert(UIViewAutoresizing.FlexibleHeight)
        self.holderView.addSubview(textView)
    }
    
    func setWebView() {
        self.webView.hidden = false
        let url = NSURL(string: "https://google.com")
        let request = NSURLRequest(URL: url!)
        webView.loadRequest(request)
    }

}
