//
//  HabitCollectionViewCell.swift
//  Happy Habits
//
//  Created by Maggy Hillen on 11/25/15.
//  Copyright © 2015 Maggy Hillen. All rights reserved.
//

import UIKit

class HabitCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var level: UILabel!
    
    func setUI(habit: Habit) {
        self.title.text = habit.title
        self.level.text = habit.level
        var color = UIColor.clearColor()
        switch habit.level {
        case "Simple":
            color = UIColor.yellowColor()
            break
        case "Moderate":
            color = UIColor.greenColor()
            break
        case "Challenging":
            color = UIColor.purpleColor()
            break
        default:
            break
        }
        self.backgroundColor = color
    }
}
