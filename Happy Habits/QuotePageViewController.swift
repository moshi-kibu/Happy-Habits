//
//  QuotePageViewController.swift
//  Happy Habits
//
//  Created by Maggy Hillen on 11/27/15.
//  Copyright © 2015 Maggy Hillen. All rights reserved.
//

import UIKit
import Parse
import ChameleonFramework

class QuotePageViewController: UIViewController {

    @IBOutlet weak var imageForQuote: UIImageView!
    @IBOutlet weak var QuoteLabel: UILabel!
    @IBOutlet weak var quotePageControl: UIPageControl!
    var timer: NSTimer = NSTimer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if allQuotes == [] {
            allQuotes = Quote.getAllQuotes()
        }
        self.updateQuotesUI()
    }
    
    override func viewDidAppear(animated: Bool) {
        timer = NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: Selector("changeScreenAutomatically"), userInfo: nil, repeats: true)
    }
    
    override func viewWillDisappear(animated: Bool) {
        timer.invalidate()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateQuotesUI() {
        self.view.layer.cornerRadius = 10
        self.imageForQuote.layer.cornerRadius = 10
        self.imageForQuote.clipsToBounds = true
        self.quotePageControl.numberOfPages = allQuotes.count
        self.changeScreen(self)
        self.QuoteLabel.font = loraFont.fontWithSize(18)
    }
    
    @IBAction func swipeRight(sender: AnyObject) {
        var currentPage = self.quotePageControl.currentPage
        currentPage -= 1
        self.quotePageControl.currentPage = currentPage
        self.changeScreen(self)
    }

    @IBAction func swipeLeft(sender: AnyObject) {
        var currentPage = self.quotePageControl.currentPage
        currentPage += 1
        self.quotePageControl.currentPage = currentPage
        self.changeScreen(self)
    }

    @IBAction func changeScreen(sender: AnyObject) {
        let thisQuote = allQuotes[self.quotePageControl.currentPage]
        self.QuoteLabel.text = thisQuote.quoteAndAuthorString()
        self.imageForQuote.image = thisQuote.getImageForQuote()
        self.QuoteLabel.textColor = UIColor.blackColor()
        self.quotePageControl.currentPageIndicatorTintColor = UIColor.flatGrayColorDark().darkenByPercentage(0.50)
        self.quotePageControl.pageIndicatorTintColor = UIColor.flatGrayColorDark()
    }
    
    func changeScreenAutomatically() {
        var currentPage = self.quotePageControl.currentPage
        currentPage += 1
        if currentPage >= allQuotes.count {
            currentPage = 0
        }
        self.quotePageControl.currentPage = currentPage
        self.changeScreen(self)
    }
}
