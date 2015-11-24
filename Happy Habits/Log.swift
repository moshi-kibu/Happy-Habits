//
//  Log.swift
//  Happy Habits
//
//  Created by Maggy Hillen on 11/19/15.
//  Copyright © 2015 Maggy Hillen. All rights reserved.
//

import Foundation

class Log: PFObject, PFSubclassing  {
    
    @NSManaged var happinessLevel : Int
    @NSManaged var userID : String
    @NSManaged var loggedAt : NSDate
    
    init(happinessLevel : Int) {
        super.init()
        self.happinessLevel = happinessLevel
        self.userID = PFUser.currentUser()!.objectId!
        self.loggedAt = NSDate()
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
        return "Log"
    }
    
    class func findLogsForCurrentUser() -> [Log] {
        let query = PFQuery(className:"Log")
        let currentUserID = PFUser.currentUser()!.objectId!
        query.whereKey("userID", equalTo: currentUserID)
        var logs = [Log]()
        do {
            logs = try query.findObjects() as! [Log]
            
        } catch {
            
        }
        return logs
    }
    
}