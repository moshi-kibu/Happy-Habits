//
//  ViewController.swift
//  Happy Habits
//
//  Created by Maggy Hillen on 11/17/15.
//  Copyright © 2015 Maggy Hillen. All rights reserved.
//

import UIKit

class ViewController: UIViewController, PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate {
    
    @IBOutlet weak var containerView: UIView!
    var user = PFUser.currentUser()
    var logs : [Log] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PFUser.logOut()
        user = PFUser.currentUser()
        if user?.username != nil {
           self.logs = Log.findLogsForCurrentUser()
        }
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
            self.containerView.hidden = false
            self.showHappyLog()
            if self.userLoggedHappinessToday(logs.last) == true {
                self.containerView.hidden = false
                self.showHappyLog()
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
            user?.saveEventually()
        }
    }
    
    func showHappyLog() {
        let happinessLogController = LogHappinessViewController()
        self.addChildViewController(happinessLogController)
        happinessLogController.view.frame = CGRectMake(0, 0, self.containerView.frame.size.width, self.containerView.frame.size.height);
        self.containerView.addSubview(happinessLogController.view)
        happinessLogController.didMoveToParentViewController(self)
    }
    
    func removeHappyLog(childController: UIViewController) {
        self.containerView.hidden = true
        childController.didMoveToParentViewController(nil)
        childController.view.removeFromSuperview()
        childController.removeFromParentViewController()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

