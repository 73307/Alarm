//
//  TestingVC.swift
//  Alarm_Demo
//
//  Created by Jeegnasa Mudsa on 10/05/24.
//

import UIKit
import UserNotifications
import AVFAudio

class TestingVC: UIViewController {
    
    private var audioPlayer: AVAudioPlayer?
    
    var uuidStr = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        self.audioPlayer?.stop()
        AudioServicesRemoveSystemSoundCompletion(kSystemSoundID_Vibrate)
        let alarms = Store.shared.alarms
        if let alarm = alarms.getAlarm(ByUUIDStr: uuidStr) {
            alarm
            if alarm.repeatWeekdays.isEmpty {
                alarm.enabled = false
                alarms.update(alarm)
            }
        }
        
        
       
    }
    
    func getPermisson() {
        let center = UNUserNotificationCenter.current()

        center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            if granted {
                print("Yay!")
            } else {
                print("D'oh")
            }
        }
    }
    
    func scheduleNotification() {
        let center = UNUserNotificationCenter.current()

        let content = UNMutableNotificationContent()
        content.title = "Late wake up call"
        content.body = "The early bird catches the worm, but the second mouse gets the cheese."
        content.categoryIdentifier = "alarm"
        content.userInfo = ["customData": "fizzbuzz"]
        content.sound = UNNotificationSound.default
        
        var dateComponents = DateComponents()
        dateComponents.hour = 12
        dateComponents.minute = 06
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        center.add(request)
    }

}
