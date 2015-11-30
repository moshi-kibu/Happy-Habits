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

class ViewController: UIViewController, PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate, ENSideMenuDelegate {
    
    @IBOutlet weak var topContainerView: UIView!
    @IBOutlet weak var bottomContainerView: UIView!
    var colorsArray = NSArray(ofColorsWithColorScheme:ColorScheme.Analogous, with:UIColor.flatSkyBlueColor(), flatScheme:true) as! [UIColor]
    var user = PFUser.currentUser()
    var logs : [Log] = []
    var quotes : [Quote] = []
    var userhabits : [Habit] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        user = PFUser.currentUser()
        self.sideMenuController()?.sideMenu?.delegate = self
        if self.logs == [] && PFUser.currentUser()?.isAuthenticated() == true {
            self.logs = Log.findLogsForCurrentUser()
        }
        if self.userhabits == [] && PFUser.currentUser()?.isAuthenticated() == true {
            self.userhabits = Habit.getHabitsForCurrentUser()
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if (PFUser.currentUser() == nil) {
            self.showLoginView()
        } else {
            self.showHabitsTable()
            self.showHappyLogOrHappyQuotes()
        }
    }
    
    func showLoginView() {
        let parseLoginViewController = LoginViewController()
        parseLoginViewController.fields = [.UsernameAndPassword, .LogInButton, .SignUpButton, .PasswordForgotten, .Facebook, .Twitter]
        parseLoginViewController.delegate = self
        parseLoginViewController.signUpController = SignUpViewController()
        parseLoginViewController.signUpController?.emailAsUsername = true
        parseLoginViewController.signUpController?.delegate = self
        self.presentViewController(parseLoginViewController, animated: false, completion: nil)
    }
    
    func logInViewController(logInController: PFLogInViewController, didLogInUser user: PFUser) {
        self.dismissViewControllerAnimated(true, completion: nil)
        self.updateUserForInitialValues()
    }
    
    func signUpViewController(signUpController: PFSignUpViewController, didSignUpUser user: PFUser) {
        self.dismissViewControllerAnimated(true, completion: nil)
        self.updateUserForInitialValues()
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
        if self.logs.last != nil {
            if self.logs.last?.loggedToday() == false {
                self.showHappyLog()
            } else {
                self.showHappyQuotes()
            }

        } else {
            self.showHappyLog()
        }
    }
    
    func showHappyLog() {
        self.clearViewsForContainer(self.topContainerView)
        let happinessLogController = LogHappinessViewController()
        self.addChildViewController(happinessLogController)
        happinessLogController.view.frame = CGRectMake(0, 0, self.topContainerView.frame.size.width, self.topContainerView.frame.size.height);
        happinessLogController.view.layer.cornerRadius = 10
        happinessLogController.view.backgroundColor = colorsArray[4].lightenByPercentage(0.10)
        self.topContainerView.addSubview(happinessLogController.view)
        happinessLogController.didMoveToParentViewController(self)
    }
    
    func showHappyQuotes() {
        self.clearViewsForContainer(self.topContainerView)
        let quotesViewController = QuotePageViewController()
        self.addChildViewController(quotesViewController)
        quotesViewController.view.frame = CGRectMake(0,0, self.topContainerView.frame.size.width, self.topContainerView.frame.size.height)
        quotesViewController.view.layer.cornerRadius = 10
        self.topContainerView.addSubview(quotesViewController.view)
        quotesViewController.didMoveToParentViewController(self)
    }
    
    func removeHappyLog(childController: UIViewController) {
        childController.didMoveToParentViewController(nil)
        childController.view.removeFromSuperview()
        childController.removeFromParentViewController()
        self.showHappyQuotes()
    }
    
    func showHabitsTable() {
        let habitsViewController = UserHabitsViewController(nibName: "UserHabitsTableView", bundle: nil)
        habitsViewController.userHabits = Habit.getHabitsForCurrentUser()
        self.addChildViewController(habitsViewController)
        habitsViewController.view.frame = CGRectMake(0, 0, self.bottomContainerView.frame.size.width, self.bottomContainerView.frame.size.height);
        self.bottomContainerView.layer.cornerRadius = 10
        self.bottomContainerView.addSubview(habitsViewController.view)
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
        toggleSideMenuView()
    }
    
}

