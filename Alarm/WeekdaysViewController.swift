//
//  WeekdaysViewController.swift
//  Alarm-ios-swift
//
//  Created by longyutao on 15/10/15.
//  Copyright (c) 2015年 LongGames. All rights reserved.
//

import UIKit

class WeekdaysViewController: UITableViewController {
    
    var weekdays: [Int]!
    var txtArray = ["Every Sunday", "Every Monday", "Every Tuesday", "Every Wednesday", "Every Thursday", "Every Friday", "Every Saturday"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        performSegue(withIdentifier: Id.weekdaysUnwindIdentifier, sender: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return txtArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: Id.weekCellIdentifier)
        if (cell == nil) {
            cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: Id.weekCellIdentifier)
        }
        
        cell!.textLabel?.text = txtArray[indexPath.row]
        cell!.textLabel?.textColor = UIColor.white
        
        for weekday in weekdays
        {
            if weekday == (indexPath.row + 1) {
                cell!.accessoryType = UITableViewCellAccessoryType.checkmark
            }
        }
        
        //delete empty seperator line
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        
        
        return cell!
    }

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)!
        
        if let index = weekdays.index(of: (indexPath.row + 1)){
            weekdays.remove(at: index)
            cell.setSelected(true, animated: true)
            cell.setSelected(false, animated: true)
            cell.accessoryType = UITableViewCellAccessoryType.none
        }
        else{
            //row index start from 0, weekdays index start from 1 (Sunday), so plus 1
            weekdays.append(indexPath.row + 1)
            cell.setSelected(true, animated: true)
            cell.setSelected(false, animated: true)
            cell.accessoryType = UITableViewCellAccessoryType.checkmark
            
        }
    }
}


extension WeekdaysViewController {
    static func repeatText(weekdays: [Int]) -> String {
        if weekdays.count == 7 {
            return "Every day"
        }
        
        if weekdays.isEmpty {
            return "Never"
        }
        
        var ret = String()
        var weekdaysSorted:[Int] = [Int]()
        
        weekdaysSorted = weekdays.sorted(by: <)
        
        for day in weekdaysSorted {
            switch day{
            case 1:
                ret += "Sun "
            case 2:
                ret += "Mon "
            case 3:
                ret += "Tue "
            case 4:
                ret += "Wed "
            case 5:
                ret += "Thu "
            case 6:
                ret += "Fri "
            case 7:
                ret += "Sat "
            default:
                //throw
                break
            }
        }
        return ret
    }
}
