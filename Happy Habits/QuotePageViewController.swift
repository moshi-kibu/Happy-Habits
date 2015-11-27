//
//  QuotePageViewController.swift
//  Happy Habits
//
//  Created by Maggy Hillen on 11/27/15.
//  Copyright © 2015 Maggy Hillen. All rights reserved.
//

import UIKit

class QuotePageViewController: UIViewController {

    @IBOutlet weak var QuoteLabel: UILabel!
    @IBOutlet weak var quotePageControl: UIPageControl!
    var quotes : [Quote] = []
    //    var quotes : [String] = [" \"Rock bottom became the solid foundation on which I rebuilt my life.\" -J.K. Rowling", "\"Experience: That most brital of teachers. But you learn, my God, do you learn.\" -C.S. Lewis"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.quotes = Quote.getAllQuotes()
        self.quotePageControl.numberOfPages = self.quotes.count
        self.QuoteLabel.text = self.quotes.first?.quoteAndAuthorString()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        self.QuoteLabel.text = self.quotes[self.quotePageControl.currentPage].quoteAndAuthorString()
    }
    
}
