//
//  ViewController.swift
//  Happy Habits
//
//  Created by Maggy Hillen on 11/17/15.
//  Copyright © 2015 Maggy Hillen. All rights reserved.
//

import UIKit
import ParseUI
import Parse
import ChameleonFramework
import QuartzCore
import Popover

class ViewController: UIViewController, PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate {
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var topContainerView: UIView!
    @IBOutlet weak var bottomContainerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if userLogs == [] && PFUser.currentUser()?.isAuthenticated() == true {
            userLogs = Log.findLogsForCurrentUser()
        }
        if userHabits == [] && PFUser.currentUser()?.isAuthenticated() == true {
            userHabits = Habit.getHabitsForCurrentUser()
        }
        
        if (PFUser.currentUser() == nil) {
            showLoginView()
        } else {
            showHabitsTable()
            showHappyLogOrHappyQuotes()
        }
    }
    
    func showLoginView() {
        let parseLoginViewController = LoginViewController()
        parseLoginViewController.fields = [.UsernameAndPassword, .LogInButton, .SignUpButton, .PasswordForgotten, .Facebook, .Twitter]
        parseLoginViewController.delegate = self
        parseLoginViewController.signUpController = SignUpViewController()
        parseLoginViewController.signUpController?.emailAsUsername = true
        parseLoginViewController.signUpController?.delegate = self
        presentViewController(parseLoginViewController, animated: false, completion: nil)
    }
    
    func logInViewController(logInController: PFLogInViewController, didLogInUser user: PFUser) {
        dismissViewControllerAnimated(true, completion: nil)
        updateUserForInitialValues()
    }
    
    func signUpViewController(signUpController: PFSignUpViewController, didSignUpUser user: PFUser) {
        dismissViewControllerAnimated(true, completion: nil)
        updateUserForInitialValues()
    }
    
    func updateUserForInitialValues() {
        let user = PFUser.currentUser()
        if user!["HappinessLog"] == nil {
            user!["HappinessLog"] = []
            user!["Habits"] = []
            user?.saveEventually()
        }
    }
    
    func showHappyLogOrHappyQuotes() {
        if userLogs.last != nil {
            if userLogs.last?.loggedToday() == false {
                showHappyLog()
            } else {
                showHappyQuotes()
            }

        } else {
            showHappyLog()
        }
    }
    
    func showHappyLog() {
        clearViewsForContainer(topContainerView)
        let happinessLogController = LogHappinessViewController()
        addChildViewController(happinessLogController)
        happinessLogController.view.frame = CGRectMake(0, 0, topContainerView.frame.size.width,topContainerView.frame.size.height);
        happinessLogController.view.layer.cornerRadius = 10
        happinessLogController.view.backgroundColor = mainColorsArray[4].lightenByPercentage(0.10)
        topContainerView.addSubview(happinessLogController.view)
        happinessLogController.didMoveToParentViewController(self)
    }
    
    func showHappyQuotes() {
        clearViewsForContainer(topContainerView)
        let quotesViewController = QuotePageViewController()
        addChildViewController(quotesViewController)
        quotesViewController.view.frame = CGRectMake(0,0, topContainerView.frame.size.width,topContainerView.frame.size.height)
        topContainerView.addSubview(quotesViewController.view)
        quotesViewController.didMoveToParentViewController(self)
    }
    
    func removeHappyLog(childController: UIViewController) {
        childController.didMoveToParentViewController(nil)
        childController.view.removeFromSuperview()
        childController.removeFromParentViewController()
        showHappyQuotes()
    }
    
    func showHabitsTable() {
        let habitsViewController = UserHabitsViewController(nibName: "UserHabitsTableView", bundle: nil)
        addChildViewController(habitsViewController)
        habitsViewController.view.frame = CGRectMake(0, 0, bottomContainerView.frame.size.width, bottomContainerView.frame.size.height);
        bottomContainerView.layer.cornerRadius = 10
        bottomContainerView.addSubview(habitsViewController.view)
        habitsViewController.didMoveToParentViewController(self)
    }
    
    func clearViewsForContainer(container: UIView) {
        if container.subviews.count > 0 {
            for view in container.subviews {
                view.removeFromSuperview()
            }
        }
    }
    
    @IBAction func menuButtonTapped(sender: AnyObject) {
        showPopoverMenu(self)
    }
}


