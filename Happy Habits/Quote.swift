//
//  Quote.swift
//  Happy Habits
//
//  Created by Maggy Hillen on 11/27/15.
//  Copyright © 2015 Maggy Hillen. All rights reserved.
//

import Foundation
import Parse


class Quote : PFObject, PFSubclassing  {
    
    @NSManaged var quoteText : String
    @NSManaged var authorName : String
    @NSManaged var imageFile : PFFile
    var image : UIImage?
    private static var allQuotes : [Quote] = []
    
    
    init(quoteText : String, authorName: String, imageFile: PFFile) {
        super.init()
        self.quoteText = quoteText
        self.authorName = authorName
        self.imageFile = imageFile
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
    
    static func getAllQuotes() -> [Quote] {
        if allQuotes == [] {
            let query = PFQuery(className:"Quote")
            query.limit = 1000
            do {
                allQuotes = try query.findObjects() as! [Quote]
                allQuotes.shuffleInPlace()
                for quote in allQuotes {
                    quote.getImageForQuote()
                }
            } catch {
                
            }
        }
        return allQuotes
    }
    
    func quoteAndAuthorString() -> String {
        var string = ""
        string += self.quoteText
        string += "\n"
        string += " -"
        string += self.authorName
        return string
    }
    
    private func getImageForQuote() {
        do {
            let imageData = try imageFile.getData()
            image = UIImage(data:imageData)!
        } catch {
            
        }
    }
    
}