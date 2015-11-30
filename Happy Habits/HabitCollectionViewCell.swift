//
//  HabitCollectionViewCell.swift
//  Happy Habits
//
//  Created by Maggy Hillen on 11/25/15.
//  Copyright © 2015 Maggy Hillen. All rights reserved.
//

import UIKit
import ChameleonFramework

class HabitCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var level: UILabel!
    var colorsArray = NSArray(ofColorsWithColorScheme:ColorScheme.Triadic, with:UIColor.flatMintColor(), flatScheme:true) as! [UIColor]
    
    func setUI(habit: Habit) {
        self.title.adjustsFontSizeToFitWidth = true
        self.title.minimumScaleFactor = 0.10
        
        self.title.text = habit.title
        self.level.text = habit.level
        var color = UIColor.clearColor()
        switch habit.level {
        case "Simple":
            color = colorsArray[1]
            break
        case "Moderate":
            color = colorsArray[2]
            break
        case "Challenging":
            color = colorsArray[3]
            break
        default:
            break
        }
        self.backgroundColor = color
    }
}
