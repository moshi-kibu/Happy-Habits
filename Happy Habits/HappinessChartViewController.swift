//
//  HappinessChartViewController.swift
//  Happy Habits
//
//  Created by Maggy Hillen on 11/23/15.
//  Copyright © 2015 Maggy Hillen. All rights reserved.
//

import UIKit
import Charts

class HappinessChartViewController: UIViewController {
    
    @IBOutlet weak var lineChartView: LineChartView!
    var logs : [Log] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        self.logs = Log.findLogsForCurrentUser()
        lineChartView.clear()
        setChart()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setChart() {
        lineChartView.noDataText = "No happiness data yet!"
        lineChartView.descriptionText = ""
        lineChartView.xAxis.labelPosition = .Bottom
        let legend = lineChartView.legend
        legend.enabled = false
        
        var dataEntries: [ChartDataEntry] = []
        var dates : [String] = []
        var colors : [UIColor] = []
        var average : Double = 0
        for i in 0..<logs.count {
            let log = logs[i]
            let value = Double(log.happinessLevel)
            average += value
            let dataEntry = ChartDataEntry(value: value, xIndex: i)
            
            switch value {
            case 1.0:
                colors.append(UIColor(red:0.89, green:0.16, blue:0.0, alpha:1.0))
                break
            case 2.0:
                colors.append(UIColor(red:0.89, green:0.43, blue:0.0, alpha:1.0))
                break
            case 3.0:
                colors.append(UIColor(red:0.87, green:0.69, blue:0.0, alpha:1.0))
                break
            case 4.0:
                colors.append(UIColor(red:0.77, green:0.86, blue:0.0, alpha:1.0))
                break
            case 5.0:
                colors.append(UIColor(red:0.5, green:0.84, blue:0.0, alpha:1.0))
                break
            case 6.0:
                colors.append(UIColor(red:0.22, green:0.83, blue:0.0, alpha:1.0))
                break
            case 7.0:
                colors.append(UIColor(red:0.0, green:0.82, blue:0.0, alpha:1.0))
                break
            case 8.0:
                colors.append(UIColor(red:0.0, green:0.8, blue:0.18, alpha:1.0))
                break
            case 9.0:
                colors.append(UIColor(red:0.0, green:0.78, blue:0.45, alpha:1.0))
                break
            case 10.0:
                colors.append(UIColor(red:0.0, green:0.76, blue:0.68, alpha:1.0))
                break
            default:
                break
            }
            
            dataEntries.append(dataEntry)
            dates.append(String(log.createdAt!)) //tweak this
        }
        
        average = Double(average / Double(logs.count))
        
        let lineChartDataSet = LineChartDataSet(yVals: dataEntries, label: "Happiness Level")
        let lineChartData = LineChartData(xVals: dates, dataSet: lineChartDataSet)
        
        
        lineChartDataSet.circleColors = colors
        
        lineChartView.data = lineChartData
        lineChartView.data?.setValueTextColor(UIColor.clearColor())
        let averageLine = ChartLimitLine(limit: average, label: "Average")
        averageLine.lineColor = UIColor.blackColor()
        lineChartView.rightAxis.removeAllLimitLines()
        lineChartView.rightAxis.addLimitLine(averageLine)
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
