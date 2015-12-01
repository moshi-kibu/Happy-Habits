//
//  PopoverMenu.swift
//  Happy Habits
//
//  Created by Maggy Hillen on 12/1/15.
//  Copyright © 2015 Maggy Hillen. All rights reserved.
//

import Foundation
import Popover

var popover: Popover!
var popoverOptions: [PopoverOption] = [
    .Type(.Down),
    .BlackOverlayColor(UIColor(white: 0.0, alpha: 0.6))
]
var popoverMenuItems = ["Logout", "Close"]

func showPopoverMenu(viewcontroller: UIViewController) {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: viewcontroller.view.frame.width / 2, height: 135))
        tableView.delegate = viewcontroller
        tableView.dataSource = viewcontroller
        tableView.scrollEnabled = false
        let point = CGPoint(x: viewcontroller.view.frame.width - 30, y: 55)
        popover = Popover(options: popoverOptions, showHandler: nil, dismissHandler: nil)
        popover.show(tableView, point: point)
}


extension UIViewController: UITableViewDelegate {
    
    public func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch popoverMenuItems[indexPath.row] {
        case "Logout":
            popover.dismiss()
            break
        case "Close":
            popover.dismiss()
            break
        default:
            break
        }
        
    }
}

extension UIViewController: UITableViewDataSource {
    
    public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 2
    }
    
    public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Default, reuseIdentifier: nil)
        cell.textLabel?.text = popoverMenuItems[indexPath.row]
        return cell
    }
}
