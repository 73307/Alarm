//
//  LabelVC.swift
//  Alarm_Demo
//
//  Created by Jeegnasa Mudsa on 06/05/24.
//

import UIKit

class LabelVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var txtField: UITextField!
    var lblTxt = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        self.txtField.delegate = self
        txtField.becomeFirstResponder()
        txtField.text = lblTxt
        txtField.returnKeyType = UIReturnKeyType.done
        txtField.enablesReturnKeyAutomatically = true

        self.txtField.returnKeyType = UIReturnKeyType.done
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        performSegue(withIdentifier: Identifier.labelUnwindIdentifier, sender: self)
    }
    
   
}

//MARK: - Action Button
extension LabelVC {
    @IBAction func btnBack(_ sender: UIButton) {
     
       dismiss(animated:  true)
       
    }
}
//MARK: - keyboard Dismiss Method
extension LabelVC {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
