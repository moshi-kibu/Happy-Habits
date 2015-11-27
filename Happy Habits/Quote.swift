//
//  Quote.swift
//  Happy Habits
//
//  Created by Maggy Hillen on 11/27/15.
//  Copyright © 2015 Maggy Hillen. All rights reserved.
//

import Foundation

class Quote : PFObject, PFSubclassing  {
    
    @NSManaged var quoteText : String
    @NSManaged var authorName : String
    
    init(quoteText : String, authorName: String) {
        super.init()
        self.quoteText = quoteText
        self.authorName = authorName
    }
    
    override init() {
        super.init()
    }
    
    override class func initialize() {
        struct Static {
            static var onceToken : dispatch_once_t = 0;
        }
        dispatch_once(&Static.onceToken) {
            self.registerSubclass()
        }
    }
    
    static func parseClassName() -> String {
        return "Quote"
    }
    
    class func getAllQuotes() -> [Quote] {
        var quotes = [Quote]()
        let query = PFQuery(className:"Quote")
        query.limit = 1000
        do {
            quotes = try query.findObjects() as! [Quote]
        } catch {
            
        }
        return quotes
    }
    
    func quoteAndAuthorString() -> String {
        var string = ""
        string += self.quoteText
        string += "\n"
        string += " -"
        string += self.authorName
        return string
    }
    
}