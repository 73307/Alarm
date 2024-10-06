//
//  AddAlarmModel.swift
//  Alarm_Demo
//
//  Created by Jeegnasa Mudsa on 06/05/24.
//

import Foundation

class AddAlarmModel {
    var SubName:String
    var ActionName: String
    var IsText: Bool
    
    init(SubName: String, ActionName: String, IsText: Bool) {
        self.SubName = SubName
        self.ActionName = ActionName
        self.IsText = IsText
    }
}

class RepeatModel {
    var dayName: String
    var shortName: String
    var isMark: Bool
    
    init(dayName: String, isMark: Bool, shortName: String) {
        self.dayName = dayName
        self.isMark = isMark
        self.shortName = shortName
    }
}

class AlarmSaveModel {
    var isActive: Bool = true
    var alarm: Date
    var time: String
    var `repeat`: String
    var label: String
    var sound: String
    var snooze: Bool
    
    init(time: String, label: String, sound: String, snooze: Bool, repeat: String, alarm: Date, isActive: Bool) {
        self.alarm = alarm
        self.time = time
        self.label = label
        self.sound = sound
        self.snooze = snooze
        self.repeat = `repeat`
       
        self.isActive = isActive
    }
    
}
