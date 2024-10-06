//
//  RepeatVc.swift
//  Alarm_Demo
//
//  Created by Jeegnasa Mudsa on 06/05/24.
//

import UIKit

class RepeatVc: UITableViewController {
    
    var weekdays: [Int] = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        performSegue(withIdentifier: Identifier.weekdaysUnwindIdentifier, sender: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        for weekday in weekdays {
            if weekday == indexPath.row {
                cell.accessoryType = UITableViewCell.AccessoryType.checkmark
            }
        }
        return cell
    }

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)!
        
        if let index = weekdays.index(of: (indexPath.row)) {
            weekdays.remove(at: index)
            cell.setSelected(true, animated: true)
            cell.setSelected(false, animated: true)
            cell.accessoryType = UITableViewCell.AccessoryType.none
        }
        else{
            
            weekdays.append(indexPath.row)
            cell.setSelected(true, animated: true)
            cell.setSelected(false, animated: true)
            cell.accessoryType = UITableViewCell.AccessoryType.checkmark
        }
    }
   
}


extension RepeatVc {
    static func repeatText(weekdays: [Int]) -> String {
        if weekdays.count == 7 {
            return "Every day"
        }
        
        if weekdays.isEmpty {
            return "Never"
        }
        
        var weekdaysSorted = weekdays.sorted(by: <)
        // Does swift has static cached emtpy string?
        var ret = ""
        for day in weekdaysSorted {
            ret += weekdaysText[day]
        }
        return ret
    }
}

fileprivate extension RepeatVc {
    static let weekdaysText = ["Sun ", "Mon ", "Tue ", "Wed ", "Thu ", "Fri ", "Sat "]
}
