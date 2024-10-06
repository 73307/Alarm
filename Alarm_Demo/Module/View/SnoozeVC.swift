//
//  SnoozeVC.swift
//  Alarm_Demo
//
//  Created by Jeegnasa Mudsa on 13/05/24.
//

import UIKit

class SnoozeVC: UIViewController {
    
    @IBOutlet weak var lblCount: UILabel!
    
    var snoozeMinuts = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        lblCount.text = "\(snoozeMinuts)"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        performSegue(withIdentifier: Identifier.snoozeSegueUnwindIdentifier, sender: self)
    }
    @IBAction func btnPluse(_ sender: UIButton) {
        if snoozeMinuts < 30 {
            snoozeMinuts += 5
            lblCount.text = "\(snoozeMinuts)"
        }
       
        
    }
    
    @IBAction func btnMinuse(_ sender: UIButton) {
        if snoozeMinuts != 0 {
            snoozeMinuts -= 5
            lblCount.text = "\(snoozeMinuts)"
        }
        
    }
//    func snoozeFunc(minutes: Int){
//        if snoozeMinuts > 0 {
//        minutes =  snoozeMinuts
//        }
//
//    }

}
extension SnoozeVC {

}
