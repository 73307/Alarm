//
//  ListOfAlarmCell.swift
//  Alarm_Demo
//
//  Created by Jeegnasa Mudsa on 06/05/24.
//

import UIKit

class ListOfAlarmCell: UITableViewCell {
    
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblAmTOPm: UILabel!
    @IBOutlet weak var lblDetails: UILabel!
    @IBOutlet weak var isActive: UISwitch!

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }
    
}
