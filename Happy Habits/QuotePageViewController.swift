//
//  QuotePageViewController.swift
//  Happy Habits
//
//  Created by Maggy Hillen on 11/27/15.
//  Copyright © 2015 Maggy Hillen. All rights reserved.
//

import UIKit

var allQuotes : [Quote] = []

class QuotePageViewController: UIViewController {

    @IBOutlet weak var QuoteLabel: UILabel!
    @IBOutlet weak var quotePageControl: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if allQuotes == [] {
            dispatch_async(dispatch_get_main_queue()) {
                allQuotes = Quote.getAllQuotes()
                self.updateQuotesUI()
            }
        } else {
            self.updateQuotesUI()
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateQuotesUI() {
        self.quotePageControl.numberOfPages = allQuotes.count
        self.QuoteLabel.text = allQuotes.first?.quoteAndAuthorString()
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
        self.QuoteLabel.text = allQuotes[self.quotePageControl.currentPage].quoteAndAuthorString()
    }
    
}
