//
//  Habit.swift
//  Happy Habits
//
//  Created by Maggy Hillen on 11/17/15.
//  Copyright © 2015 Maggy Hillen. All rights reserved.
//

import Foundation
import Parse

class Habit: PFObject, PFSubclassing  {
    @NSManaged var title : String
    @NSManaged var level : String
    @NSManaged var details : String
    @NSManaged var studyURL : String
    
    private static var allHabits : [Habit] = []
    
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
    
    static func getAllHabits() -> [Habit] {
        if allHabits == [] {
            let query = PFQuery(className:"Habit")
            do {
                allHabits = try query.findObjects() as! [Habit]
                allHabits.shuffleInPlace()
            } catch {
                
            }
        }

        return allHabits
    }
    
    class func getHabitsForCurrentUser() -> [Habit] {
        let user = PFUser.currentUser()
        var habits: [Habit] = []
        do {
           let userHabits = user!["Habits"] as! [Habit]
            for habit in userHabits {
                let fetchedHabit = try habit.fetch()
                habits.append(fetchedHabit)
            }
        } catch {
            
        }
        return habits
    }
    
}