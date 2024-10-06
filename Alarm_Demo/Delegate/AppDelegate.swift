//
//  AppDelegate.swift
//  Alarm_Demo
//
//  Created by Jeegnasa Mudsa on 06/05/24.
//

import UIKit
import Foundation
import AudioToolbox
import AVFoundation
import UserNotifications
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate, AVAudioPlayerDelegate, UNUserNotificationCenterDelegate, AlarmApplicationDelegate {
    
    var window: UIWindow?
    var timer: Timer?
    let taskId = "Local notification schedule"
    var backgroundTaskId = UIBackgroundTaskIdentifier.invalid
    private var uuidStr: String = ""
    private var audioPlayer: AVAudioPlayer?
    private let notificationScheduler: NotificationSchedulerDelegate = NotificationScheduler()
    private let alarms: Alarms = Store.shared.alarms
    var currentAlarm: Alarm?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
       
        
        do {
//            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
        } catch let error as NSError{
            print("could not set session. err:\(error.localizedDescription)")
        }
        do {
            try AVAudioSession.sharedInstance().setActive(true)
        } catch let error as NSError{
            print("could not active session. err:\(error.localizedDescription)")
        }
        
        UNUserNotificationCenter.current().delegate = self
        notificationScheduler.requestAuthorization()
        notificationScheduler.registerNotificationCategories()
        NotificationCenter.default.addObserver(self, selector: #selector(loadList), name: NSNotification.Name(rawValue: "load"), object: nil)
        application.registerForRemoteNotifications()
        return true
    }
    
    @objc func loadList(){
        //load data here
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
        stopMusicFunc()
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        print(userInfo.count)
        completionHandler(.newData)
    }
    
    // MARK: UISceneSession Lifecycle
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    func application(_ application: UIApplication, performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        print("performFetchWithCompletionHandler", completionHandler(.newData))
        // Handle background fetch operations here, including processing notifications
        // You can schedule or handle notifications in this method
        completionHandler(.newData) // Specify the result of the background fetch operation
    }
   
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        print("didDiscardSceneSessions")
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}
extension AppDelegate {
//MARK: - Will Present Method
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {

        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
//        stopMusicFunc()
        print(notification.date)
        //show an alert window
        let alertController = UIAlertController(title: "Alarm", message: nil, preferredStyle: .alert)
        let userInfo = notification.request.content.userInfo
        guard
            let snoozeEnabled = userInfo["snooze"] as? Bool,
            let soundName = userInfo["soundName"] as? String,
            let uuidStr = userInfo["uuid"] as? String
        else {return}
        self.uuidStr = uuidStr
        playSound(soundName)
        
        //schedule notification for snooze
        if snoozeEnabled {
            let snoozeOption = UIAlertAction(title: "Snooze1", style: .default) {
                (action:UIAlertAction) in
                self.audioPlayer?.stop()
                let label = notification.request.content.body
                let snoozeTime = notification.date
                print(snoozeTime)
                self.notificationScheduler.setNotificationForSnooze(alarmLabel: label,ringtoneName: soundName, snoozeMinute: 1, uuid: uuidStr, dateTime: snoozeTime)
            }
            
            alertController.addAction(snoozeOption)
        }
        
        let stopOption = UIAlertAction(title: "OK", style: .default) {
            (action:UIAlertAction) in
            self.stopMusicFunc()
        }
        
        alertController.addAction(stopOption)
        window?.visibleViewController?.navigationController?.present(alertController, animated: true, completion: nil)
        completionHandler(.banner)
    }
//MARK: - Will Present Method
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        // Handle user interaction with notifications
        
        print(response.notification.date)
        if response.actionIdentifier == UNNotificationDefaultActionIdentifier {
            stopMusicFunc()
            // User tapped on the notification banner
            print("User tapped on the notification")
        } else if response.actionIdentifier == UNNotificationDismissActionIdentifier {
            // User dismissed the notification
            stopMusicFunc()
            print("User dismissed the notification")
        } else if response.actionIdentifier == UNNotificationDefaultActionIdentifier {
            // User swiped up on the notification banner
            print("User swiped up on the notification")
        } else {
            let userInfo = response.notification.request.content.userInfo
            guard
                let soundName = userInfo["soundName"] as? String,
                let uuid = userInfo["uuid"] as? String
            else {return}
            
            switch response.actionIdentifier {
            case Identifier.snoozeActionIdentifier:
                self.audioPlayer?.stop()
                AudioServicesRemoveSystemSoundCompletion(kSystemSoundID_Vibrate)
                // notification fired when app in background, snooze button clicked
                let label = response.notification.request.content.body
                let snoozeTime = response.notification.date
                print(snoozeTime)
                let currentTime = Date()
                print(currentTime)
//                let date = NotificationScheduler.correctSecondComponent(date: )
                notificationScheduler.setNotificationForSnooze(alarmLabel:label ,ringtoneName: soundName, snoozeMinute: 1, uuid: uuid, dateTime: currentTime)
                break
            case Identifier.stopActionIdentifier:
                // notification fired when app in background, ok button clicked
                let alarms = Store.shared.alarms
                if let alarm = alarms.getAlarm(ByUUIDStr: uuid) {
                    if alarm.repeatWeekdays.isEmpty {
                        alarm.enabled = false
                        alarms.update(alarm)
                    }
                }
                stopMusicFunc()
                break
            default:
                break
            }
//
        }
        
        
        completionHandler()
    }
    
    //AlarmApplicationDelegate protocol
    func playSound(_ soundName: String) {
        //vibrate phone first
        AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
        //set vibrate callback
        AudioServicesAddSystemSoundCompletion(SystemSoundID(kSystemSoundID_Vibrate),nil,
                                              nil,
                                              { (_:SystemSoundID, _:UnsafeMutableRawPointer?) -> Void in
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
        },
                                              nil)
        
        guard let filePath = Bundle.main.path(forResource: soundName, ofType: "mp3") else {fatalError()}
        let url = URL(fileURLWithPath: filePath)
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            
        } catch let error as NSError {
            audioPlayer = nil
            print("audioPlayer error \(error.localizedDescription)")
            return
            
        }
        
        if let player = audioPlayer {
            player.delegate = self
            player.prepareToPlay()
            //negative number means loop infinity
            player.numberOfLoops = -1
            player.play()
        }
    }
    
    func stopMusicFunc() {
        self.audioPlayer?.stop()
        AudioServicesRemoveSystemSoundCompletion(kSystemSoundID_Vibrate)
        let alarms = Store.shared.alarms
        if let alarm = alarms.getAlarm(ByUUIDStr: uuidStr) {
            
            if alarm.repeatWeekdays.isEmpty {
                alarm.enabled = false
                alarms.update(alarm)
            }
        }
    }
}
extension AppDelegate {
    static func correctSecondComponent(date: Date, calendar: Calendar = Calendar(identifier: Calendar.Identifier.gregorian)) -> Date {
        let second = calendar.component(.second, from: date)
        let d = (calendar as NSCalendar).date(byAdding: NSCalendar.Unit.second, value: second, to: date, options:.matchStrictly)!
        return d
    }
}
