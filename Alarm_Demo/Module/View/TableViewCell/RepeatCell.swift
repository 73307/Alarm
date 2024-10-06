//
//  RepeatCell.swift
//  Alarm_Demo
//
//  Created by Jeegnasa Mudsa on 06/05/24.
//

import UIKit

class RepeatCell: UITableViewCell {
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var IsTrue: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
