//
//  Log.swift
//  Happy Habits
//
//  Created by Maggy Hillen on 11/19/15.
//  Copyright © 2015 Maggy Hillen. All rights reserved.
//

import Foundation
import Parse


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
        var logs : [Log] = []
        do {
            logs = PFUser.currentUser()!["HappinessLog"] as! [Log]
            for log in logs {
                let fetchedLog = try log.fetch()
                logs.append(fetchedLog)
            }
        } catch {
            
        }
        return logs
    }
    
    func loggedToday() -> Bool {
        let createdDate = (loggedAt) as NSDate
        let today = NSDate()
        let cal = NSCalendar.currentCalendar()
        let components = cal.components([.Day], fromDate: createdDate, toDate: today, options: [])
        return (components.day < 1)
    }
    
}