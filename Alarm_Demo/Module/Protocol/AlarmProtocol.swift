//
//  AlarmProtocol.swift
//  Alarm_Demo
//
//  Created by Jeegnasa Mudsa on 07/05/24.
//

import Foundation

protocol NavigatDelegate : AnyObject {
    func navigateToRepeat()
}
protocol AlarmSaveData: AnyObject {
    func DataPassing(info: [AlarmSaveModel])
}
