//
//  ViewController.swift
//  Happy Habits
//
//  Created by Maggy Hillen on 11/17/15.
//  Copyright © 2015 Maggy Hillen. All rights reserved.
//

import UIKit

class ViewController: UIViewController, PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate {
    
    @IBOutlet weak var topContainerView: UIView!
    @IBOutlet weak var bottomContainerView: UIView!

    var user = PFUser.currentUser()
    var logs : [Log] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        user = PFUser.currentUser()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if (PFUser.currentUser() == nil) {
            let parseLoginViewController = LoginViewController()
            parseLoginViewController.fields = [.UsernameAndPassword, .LogInButton, .SignUpButton, .PasswordForgotten, .Facebook, .Twitter]
            parseLoginViewController.delegate = self
            parseLoginViewController.signUpController = SignUpViewController()
            parseLoginViewController.signUpController?.emailAsUsername = true
            parseLoginViewController.signUpController?.delegate = self
            self.presentViewController(parseLoginViewController, animated: false, completion: nil)
        } else {
            self.showHabitsTable()
            self.showHappyLogOrHappyQuotes()
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        if self.topContainerView.subviews.count > 0 {
            for view in self.topContainerView.subviews {
                view.removeFromSuperview()
            }
        }
    }
    
    func logInViewController(logInController: PFLogInViewController, didLogInUser user: PFUser) {
        self.dismissViewControllerAnimated(true, completion: nil)
        self.updateUserForInitialValues()
    }
    
    func signUpViewController(signUpController: PFSignUpViewController, didSignUpUser user: PFUser) {
        self.dismissViewControllerAnimated(true, completion: nil)
        self.updateUserForInitialValues()
    }
    
    func userLoggedHappinessToday(log: Log?) -> Bool {
        if log == nil {
            return false
        }
        let createdDate = (log!.createdAt)! as NSDate
        let today = NSDate()
        let cal = NSCalendar.currentCalendar()
        let components = cal.components([.Day], fromDate: createdDate, toDate: today, options: [])
        return (components.day < 1)
    }
    
    func updateUserForInitialValues() {
        user = PFUser.currentUser()
        if user!["HappinessLog"] == nil {
            user!["HappinessLog"] = []
            user!["Habits"] = []
            user?.saveEventually()
        }
    }
    
    func showHappyLogOrHappyQuotes() {
        dispatch_async(dispatch_get_main_queue()) {
            self.logs = Log.findLogsForCurrentUser()
            if self.userLoggedHappinessToday(self.logs.last) == false {
                self.showHappyLog()
            } else {
                self.showHappyQuotes()
            }
        }
    }
    
    func showHappyLog() {
        let happinessLogController = LogHappinessViewController()
        self.addChildViewController(happinessLogController)
        happinessLogController.view.frame = CGRectMake(0, 0, self.topContainerView.frame.size.width, self.topContainerView.frame.size.height);
        self.topContainerView.addSubview(happinessLogController.view)
        happinessLogController.didMoveToParentViewController(self)
    }
    
    func showHappyQuotes() {
        let quotesViewController = QuotePageViewController()
        self.addChildViewController(quotesViewController)
        quotesViewController.view.frame = CGRectMake(0,0, self.topContainerView.frame.size.width, self.topContainerView.frame.size.height)
        self.topContainerView.addSubview(quotesViewController.view)
        quotesViewController.didMoveToParentViewController(self)
    }
    
    func removeHappyLog(childController: UIViewController) {
        self.topContainerView.hidden = true
        childController.didMoveToParentViewController(nil)
        childController.view.removeFromSuperview()
        childController.removeFromParentViewController()
    }
    
    func showHabitsTable() {
        let habitsTable = UserHabitsTableViewController()
        habitsTable.view.frame = CGRectMake(0, 0, self.bottomContainerView.frame.size.width, self.topContainerView.frame.size.height);
        self.bottomContainerView.addSubview(habitsTable.view)
        habitsTable.didMoveToParentViewController(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

