//
//  NotificationProtocol.swift
//  Alarm_Demo
//
//  Created by Jeegnasa Mudsa on 09/05/24.
//

import Foundation
import UIKit

protocol NotificationSchedulerDelegate {
    func requestAuthorization()
    func registerNotificationCategories()
    func setNotification(alarmLabel: String ,date: Date, ringtoneName: String, repeatWeekdays: [Int], snoozeEnabled: Bool, onSnooze: Bool, uuid: String)
    func setNotificationForSnooze(alarmLabel: String ,ringtoneName: String, snoozeMinute: Int, uuid: String,dateTime: Date)
    func cancelNotification(ByUUIDStr uuid: String)
    func updateNotification(alarmLabel: String, ByUUIDStr uuid: String, date: Date, ringtoneName: String, repeatWeekdays: [Int], snoonzeEnabled: Bool)
    
    func syncAlarmStateWithNotification()
}

