//
//  LocalDataManager.swift
//  Alarm_Demo
//
//  Created by Jeegnasa Mudsa on 06/05/24.
//

import Foundation
import UIKit
class LocalDataManager {
    static let shared = LocalDataManager()
    private init() {
        
    }
    
    var localData : [RepeatModel] = []
    let item = [RepeatModel(dayName: "Every Sunday", isMark: false, shortName: "Sun"),
                RepeatModel(dayName: "Every Monday", isMark: false, shortName: "Mon"),
                RepeatModel(dayName: "Every Tuesday", isMark: false, shortName: "Tus"),
                RepeatModel(dayName: "Every Wednesday", isMark: false, shortName: "Wed"),
                RepeatModel(dayName: "Every Thursday", isMark: false, shortName: "Thu"),
                RepeatModel(dayName: "Every Firday", isMark: false, shortName: "Fri"),
                RepeatModel(dayName: "Every Saturday", isMark: false, shortName: "Sat")]
    var alarmMainData: [AlarmSaveModel]  = []
    
}
