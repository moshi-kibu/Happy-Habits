//
//  HappinessChartViewController.swift
//  Happy Habits
//
//  Created by Maggy Hillen on 11/23/15.
//  Copyright © 2015 Maggy Hillen. All rights reserved.
//

import UIKit
import Charts


public func ==(lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs === rhs || lhs.compare(rhs) == .OrderedSame
}

public func <(lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs.compare(rhs) == .OrderedAscending
}

extension NSDate: Comparable { }


class HappinessChartViewController: UIViewController {
    
    @IBOutlet weak var lineChartView: LineChartView!
    @IBOutlet weak var timeSelector: UISegmentedControl!
    var logs : [Log] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        self.logs = Log.findLogsForCurrentUser()
        checkSelectorAndSetChart()
    }

    @IBAction func timeSelectorChanged(sender: UISegmentedControl) {
        checkSelectorAndSetChart()
    }
    
    func checkSelectorAndSetChart() {
        let today = NSDate()
        var pastDate : NSDate
        switch self.timeSelector.selectedSegmentIndex {
        case 0:
            pastDate = today.dateByAddingTimeInterval(-(60*60*24*7))
            setChart(pastDate, maxDate: today, forYear: false)
            break
        case 1:
            pastDate = today.dateByAddingTimeInterval(-(60*60*24*30))
            setChart(pastDate, maxDate: today, forYear: false)
            break
        case 2:
            pastDate = today.dateByAddingTimeInterval(-(60*60*24*365))
            setChart(pastDate, maxDate: today, forYear: true)
            break
        default:
            break
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setChart(minDate: NSDate, maxDate: NSDate, forYear: Bool) {
        lineChartView.clear()
        setChartDataAndColors(minDate, maxDate: maxDate, forYear: forYear)
        setChartUIDefaults()
    }
    
    func setChartUIDefaults() {
        lineChartView.noDataText = "No happiness data yet!"
        lineChartView.descriptionText = ""
        lineChartView.data?.setValueTextColor(UIColor.clearColor())
        lineChartView.xAxis.labelPosition = .Bottom
        let legend = lineChartView.legend
        legend.enabled = false
    }
    
    func setLimitLine(average: Double) {
        let averageLine = ChartLimitLine(limit: average, label: "Average")
        averageLine.lineColor = UIColor.blackColor()
        lineChartView.rightAxis.removeAllLimitLines()
        lineChartView.rightAxis.addLimitLine(averageLine)
    }
    
    func setChartDataAndColors(minDate: NSDate, maxDate: NSDate, forYear: Bool) {
        var dataEntries: [ChartDataEntry] = []
        var dates : [String] = []
        var colors : [UIColor] = []
        var average : Double = 0
        
        var logsForDateRange = logs.filter({($0["loggedAt"]! as! NSDate) >= minDate && ($0["loggedAt"]! as! NSDate) <= maxDate})
        if logsForDateRange.count > 1 {
            
        
            if forYear == false {
                for i in 0..<logsForDateRange.count {
                    let log = logsForDateRange[i]
                    let value = Double(log.happinessLevel)
                    average += value
                    
                    let dataEntry = ChartDataEntry(value: value, xIndex: i)
                    colors.append(selectColor(value))
                    dataEntries.append(dataEntry)
                    dates.append(String(log["loggedAt"]))
                }
                average = Double(average / Double(logsForDateRange.count))
            }
            else {
                let months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
                var monthsCounted = 0
                for i in 0..<months.count {
                    var monthInt = 0
                    switch months[i] {
                        case "January":
                            monthInt = 1
                        break
                        case "February":
                            monthInt = 2
                        break
                        case "March":
                            monthInt = 3
                        break
                        case "April":
                            monthInt = 4
                        break
                        case "May":
                            monthInt = 5
                        break
                        case "June":
                            monthInt = 6
                        break
                        case "July":
                            monthInt = 7
                        break
                        case "August":
                            monthInt = 8
                        break
                        case "September":
                            monthInt = 9
                        break
                        case "October":
                            monthInt = 10
                        break
                        case "November":
                            monthInt = 11
                        break
                        case "December":
                            monthInt = 12
                        break
                    default:
                        break
                    }
                    
                    let monthLogs = logsForDateRange.filter({dateIsInMonth($0["loggedAt"] as! NSDate, month: monthInt)})
                    
                    
                    if monthLogs.count > 0 {
                        monthsCounted += 1
                        var averageMonthValue = 0
                        
                        for log in monthLogs {
                            averageMonthValue += log.happinessLevel
                        }
                        
                        let monthValue = Double(averageMonthValue/monthLogs.count)
                        average += monthValue
                        
                        
                        let dataEntry = ChartDataEntry(value: monthValue , xIndex: monthsCounted)
                        colors.append(selectColor(monthValue))
                        dataEntries.append(dataEntry)
                        dates.append(months[i])
                    }
                }
                average = (average / Double(monthsCounted))
            }
            setLimitLine(average)
            let lineChartDataSet = LineChartDataSet(yVals: dataEntries, label: "Happiness Level")
            let lineChartData = LineChartData(xVals: dates, dataSet: lineChartDataSet)
            lineChartDataSet.circleColors = colors
            lineChartView.data = lineChartData
        }
    }
    
    func dateIsInMonth(date: NSDate, month: Int) -> Bool {
        let calendar = NSCalendar.currentCalendar()
        let monthComponent = calendar.components(NSCalendarUnit.Month, fromDate: date)
        return monthComponent.month == month
    }
    
    func selectColor(value: Double) -> UIColor {
        var color : UIColor = UIColor()
        switch value {
        case 1.0:
            color = UIColor(red:0.89, green:0.16, blue:0.0, alpha:1.0)
            break
        case 2.0:
            color = UIColor(red:0.89, green:0.43, blue:0.0, alpha:1.0)
            break
        case 3.0:
            color = UIColor(red:0.87, green:0.69, blue:0.0, alpha:1.0)
            break
        case 4.0:
            color = UIColor(red:0.77, green:0.86, blue:0.0, alpha:1.0)
            break
        case 5.0:
            color = UIColor(red:0.5, green:0.84, blue:0.0, alpha:1.0)
            break
        case 6.0:
            color = UIColor(red:0.22, green:0.83, blue:0.0, alpha:1.0)
            break
        case 7.0:
            color = UIColor(red:0.0, green:0.82, blue:0.0, alpha:1.0)
            break
        case 8.0:
            color = UIColor(red:0.0, green:0.8, blue:0.18, alpha:1.0)
            break
        case 9.0:
            color = UIColor(red:0.0, green:0.78, blue:0.45, alpha:1.0)
            break
        case 10.0:
            color = UIColor(red:0.0, green:0.76, blue:0.68, alpha:1.0)
            break
        default:
            color = UIColor.blackColor()
            break
        }
        return color
    }
    
    func testDataSet() -> [Log] {
        let testLogs = [Log(happinessLevel: 10),
            Log(happinessLevel: 7),
            Log(happinessLevel: 8),
            Log(happinessLevel: 9),
            Log(happinessLevel: 6),
            Log(happinessLevel: 8),
            Log(happinessLevel: 9),
            Log(happinessLevel: 7),
            Log(happinessLevel: 5),
            Log(happinessLevel: 6),
            Log(happinessLevel: 5),
            Log(happinessLevel: 7),
            Log(happinessLevel: 10),
            Log(happinessLevel: 7),
            Log(happinessLevel: 8),
            Log(happinessLevel: 9),
            Log(happinessLevel: 6),
            Log(happinessLevel: 8),
            Log(happinessLevel: 9),
            Log(happinessLevel: 7),
            Log(happinessLevel: 5),
            Log(happinessLevel: 6),
            Log(happinessLevel: 5),
            Log(happinessLevel: 7),
            Log(happinessLevel: 10),
            Log(happinessLevel: 7),
            Log(happinessLevel: 8),
            Log(happinessLevel: 9),
            Log(happinessLevel: 6),
            Log(happinessLevel: 8),
            Log(happinessLevel: 9),
            Log(happinessLevel: 7),
            Log(happinessLevel: 5),
            Log(happinessLevel: 6),
            Log(happinessLevel: 5),
            Log(happinessLevel: 7),
            Log(happinessLevel: 10),
            Log(happinessLevel: 7),
            Log(happinessLevel: 8),
            Log(happinessLevel: 9),
            Log(happinessLevel: 6),
            Log(happinessLevel: 8),
            Log(happinessLevel: 9),
            Log(happinessLevel: 7),
            Log(happinessLevel: 5),
            Log(happinessLevel: 6),
            Log(happinessLevel: 5),
            Log(happinessLevel: 7),
            Log(happinessLevel: 10),
            Log(happinessLevel: 7),
            Log(happinessLevel: 8),
            Log(happinessLevel: 9),
            Log(happinessLevel: 6),
            Log(happinessLevel: 8),
            Log(happinessLevel: 9),
            Log(happinessLevel: 7),
            Log(happinessLevel: 5),
            Log(happinessLevel: 6),
            Log(happinessLevel: 5),
            Log(happinessLevel: 7),
            Log(happinessLevel: 10),
            Log(happinessLevel: 7),
            Log(happinessLevel: 8),
            Log(happinessLevel: 9),
            Log(happinessLevel: 6),
            Log(happinessLevel: 8),
            Log(happinessLevel: 9),
            Log(happinessLevel: 7),
            Log(happinessLevel: 5),
            Log(happinessLevel: 6),
            Log(happinessLevel: 5),
            Log(happinessLevel: 7),
            Log(happinessLevel: 10),
            Log(happinessLevel: 7),
            Log(happinessLevel: 8),
            Log(happinessLevel: 9),
            Log(happinessLevel: 6),
            Log(happinessLevel: 8),
            Log(happinessLevel: 9),
            Log(happinessLevel: 7),
            Log(happinessLevel: 5),
            Log(happinessLevel: 6),
            Log(happinessLevel: 5),
            Log(happinessLevel: 7),
            Log(happinessLevel: 10),
            Log(happinessLevel: 7),
            Log(happinessLevel: 8),
            Log(happinessLevel: 9),
            Log(happinessLevel: 6),
            Log(happinessLevel: 8),
            Log(happinessLevel: 9),
            Log(happinessLevel: 7),
            Log(happinessLevel: 5),
            Log(happinessLevel: 6),
            Log(happinessLevel: 5),
            Log(happinessLevel: 7),
            Log(happinessLevel: 10),
            Log(happinessLevel: 7),
            Log(happinessLevel: 8),
            Log(happinessLevel: 9),
            Log(happinessLevel: 6),
            Log(happinessLevel: 8),
            Log(happinessLevel: 9),
            Log(happinessLevel: 7),
            Log(happinessLevel: 5),
            Log(happinessLevel: 6),
            Log(happinessLevel: 5),
            Log(happinessLevel: 7),
            Log(happinessLevel: 10),
            Log(happinessLevel: 7),
            Log(happinessLevel: 8),
            Log(happinessLevel: 9),
            Log(happinessLevel: 6),
            Log(happinessLevel: 8),
            Log(happinessLevel: 9),
            Log(happinessLevel: 7),
            Log(happinessLevel: 5),
            Log(happinessLevel: 6),
            Log(happinessLevel: 5),
            Log(happinessLevel: 7),
            Log(happinessLevel: 10),
            Log(happinessLevel: 7)]
        var date = NSDate()
        for log in testLogs {
            log["loggedAt"] = date
            date = date.dateByAddingTimeInterval(-(60*60*24*1))
        }
        return testLogs
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
