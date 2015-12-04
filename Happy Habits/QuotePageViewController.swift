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
        updateQuotesUI()
        changeScreen(self)
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
        view.layer.cornerRadius = 10
        imageForQuote.layer.cornerRadius = 10
        imageForQuote.clipsToBounds = true
        quotePageControl.numberOfPages = Quote.getAllQuotes().count
        QuoteLabel.font = loraFont.fontWithSize(18)
    }
    
    @IBAction func swipeRight(sender: AnyObject) {
        var currentPage = quotePageControl.currentPage
        currentPage -= 1
        quotePageControl.currentPage = currentPage
        changeScreen(self)
    }

    @IBAction func swipeLeft(sender: AnyObject) {
        var currentPage = quotePageControl.currentPage
        currentPage += 1
        quotePageControl.currentPage = currentPage
        changeScreen(self)
    }

    @IBAction func changeScreen(sender: AnyObject) {
        let thisQuote = Quote.getAllQuotes()[quotePageControl.currentPage]
        QuoteLabel.text = thisQuote.quoteAndAuthorString()
        imageForQuote.image = thisQuote.image
        QuoteLabel.textColor = UIColor.blackColor()
        quotePageControl.currentPageIndicatorTintColor = UIColor.flatGrayColorDark().darkenByPercentage(0.50)
        quotePageControl.pageIndicatorTintColor = UIColor.flatGrayColorDark()
    }
    
    func changeScreenAutomatically() {
        var currentPage = quotePageControl.currentPage
        currentPage += 1
        if currentPage >= Quote.getAllQuotes().count {
            currentPage = 0
        }
        quotePageControl.currentPage = currentPage
        changeScreen(self)
    }
}
