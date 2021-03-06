//
//  WelcomeViewController.swift
//  Happy Habits
//
//  Created by Maggy Hillen on 11/17/15.
//  Copyright © 2015 Maggy Hillen. All rights reserved.
//
import ParseUI 

class LoginViewController : PFLogInViewController {
    
    var backgroundImage : UIImageView!;
    var viewsToAnimate: [UIView!]!;
    var viewsFinalYPosition : [CGFloat]!;
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        logInView?.autoresizesSubviews
        
        self.fields = [.UsernameAndPassword, .LogInButton, .SignUpButton, .PasswordForgotten, .Facebook, .Twitter]
        self.emailAsUsername = true
        
        // set our custom background image
        backgroundImage = UIImageView(image: UIImage(named: "Happy"))
        backgroundImage.contentMode = UIViewContentMode.ScaleAspectFill
        logInView!.insertSubview(backgroundImage, atIndex: 0)
        
        // remove the parse Logo
        let logo = UILabel()
        logo.text = "Happy Habits"
        logo.textColor = UIColor.flatSkyBlueColor()
        logo.font = UIFont(name: "Norican-Regular", size: 70)
        logo.shadowColor = UIColor.whiteColor()
        logo.shadowOffset = CGSizeMake(2, 2)
        logo.adjustsFontSizeToFitWidth = true
        logInView?.logo = logo
        
        
        // set forgotten password button to white
        logInView?.passwordForgottenButton?.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        logInView?.passwordForgottenButton?.backgroundColor = UIColor.clearColor()
        
        // make the background of the login button pop more
        logInView?.logInButton?.setBackgroundImage(nil, forState: .Normal)
        logInView?.logInButton?.backgroundColor = UIColor.flatGreenColor()
        // make the buttons classier
        customizeButton(logInView?.facebookButton!)
        customizeButton(logInView?.twitterButton!)
        customizeButton(logInView?.signUpButton!)
        
        // create an array of all the views we want to animate in when we launch
        // the screen
        viewsToAnimate = [self.logInView?.usernameField, self.logInView?.passwordField, self.logInView?.logInButton, self.logInView?.passwordForgottenButton, self.logInView?.facebookButton, self.logInView?.twitterButton, self.logInView?.signUpButton, self.logInView?.logo]
        
    }
    
    func customizeButton(button: UIButton!) {
        button.setBackgroundImage(nil, forState: .Normal)
        button.backgroundColor = UIColor.clearColor()
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.whiteColor().CGColor
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // stretch background image to fill screen
        backgroundImage.frame = CGRectMake( 0,  0,  logInView!.frame.width,  logInView!.frame.height)
        
        // position logo at top with larger frame
        logInView!.logo!.sizeToFit()
        let logoFrame = logInView!.logo!.frame
        logInView!.logo!.frame = CGRectMake(logoFrame.origin.x, logInView!.usernameField!.frame.origin.y - logoFrame.height - 16, logInView!.frame.width,  logoFrame.height)
        
        // We to position all the views off the bottom of the screen
        // and then make them rise back to where they should be
        // so we track their final position in an array
        // but change their frame so they are shifted downwards off the screen
        viewsFinalYPosition = [CGFloat]();
        for viewToAnimate in viewsToAnimate {
            let currentFrame = viewToAnimate.frame
            viewsFinalYPosition.append(currentFrame.origin.y)
            viewToAnimate.frame = CGRectMake(currentFrame.origin.x, self.view.frame.height + currentFrame.origin.y, currentFrame.width, currentFrame.height)
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        // Now we'll animate all our views back into view
        // and, using the final position we stored, we'll
        // reset them to where they should be
        if viewsFinalYPosition.count == self.viewsToAnimate.count {
            UIView.animateWithDuration(1, delay: 0.0, options: .CurveEaseInOut,  animations: { () -> Void in
                for viewToAnimate in self.viewsToAnimate {
                    let currentFrame = viewToAnimate.frame
                    viewToAnimate.frame = CGRectMake(currentFrame.origin.x, self.viewsFinalYPosition.removeAtIndex(0), currentFrame.width, currentFrame.height)
                }
                }, completion: nil)
        }
    }
    
}