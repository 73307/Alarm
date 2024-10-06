////
////  Database.swift
////  
////
////  Created by CMR0230 on 20/02/23.
////
//
//import Foundation
//import CoreData
//import UIKit
//
//// MARK: save data
//class DataBase
//{
//    func saveData(coreAlarm: Date, coreTime: String, coreLabel: String,coreSound: String, coreSnooze: Bool, coreRepeat: String, coreIsActive: Bool, uuid: UUID) {
//        
//        let appDe = (UIApplication.shared.delegate) as! AppDelegate
//        
//        
//        let context = appDe.persistentContainer.viewContext
//        
//        
//        let contectObject = NSEntityDescription.insertNewObject(forEntityName: "Alarms", into: context) as! Alarms
//        
//        contectObject.alarm = coreAlarm
//        contectObject.time = coreTime
//        contectObject.label = coreLabel
//        contectObject.repeats = coreRepeat
//        contectObject.isActive = coreIsActive
//        contectObject.sound = coreSound
//        contectObject.snooze = coreSnooze
//        contectObject.uuid = uuid
//        
//        
//        do {
//            try context.save()
//            print("Data has been saved")
//        }
//        catch
//        {
//            print("Error has been occured during ")
//        }
//        }
//
//    func fatchData()-> [Alarms] {
//        
//        var cData = [Alarms]()
//        let appDe = (UIApplication.shared.delegate) as! AppDelegate
//        let context = appDe.persistentContainer.viewContext
//        do
//        {
//            cData = try context.fetch(Alarms.fetchRequest()) as! [Alarms]
//        }
//        catch
//        {
//            print("Error ooccured during fetch request")
//        }
//        return cData
//    }
//}
