//
//  User.swift
//  Happy Habits
//
//  Created by Maggy Hillen on 11/17/15.
//  Copyright © 2015 Maggy Hillen. All rights reserved.
//

import Foundation

class User : PFUser {
    
    @NSManaged var habits : [Habit]
    @NSManaged var currentHappiness : Int
    @NSManaged var happinessOverTime : [NSDate : Int]
    
    override class func initialize() {
        self.registerSubclass()
    }
    
    override init() {
        super.init()
    }
    
    convenience init(habits: [Habit] = [], currentHappiness : Int) {
        self.init()
        self.habits = []
        self.currentHappiness = currentHappiness
        self.happinessOverTime = [NSDate() : currentHappiness]
    }
    
    func updateHappiness(newHappiness: Int) {
        self.currentHappiness = newHappiness
        self.happinessOverTime[NSDate()] = newHappiness
        self.saveEventually()
    }
}