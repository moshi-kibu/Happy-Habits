//
//  Habit.swift
//  Happy Habits
//
//  Created by Maggy Hillen on 11/17/15.
//  Copyright © 2015 Maggy Hillen. All rights reserved.
//

import Foundation

class Habit: PFObject, PFSubclassing  {
    @NSManaged var title : String
    @NSManaged var level : String
    @NSManaged var details : String
    @NSManaged var studyURL : String
    
    init(title:String, level: String, details: String, studyURL: String) {
        super.init()
        self.title = title
        self.level = level
        self.details = details
        self.studyURL = studyURL
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
        return "Habit"
    }
    
    class func getAllHabits() -> [Habit] {
        var habits = [Habit]()
        let query = PFQuery(className:"Habit")
        query.limit = 1000
        do {
            habits = try query.findObjects() as! [Habit]
        } catch {
            
        }
        return habits
    }
    
}