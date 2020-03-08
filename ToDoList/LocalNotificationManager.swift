//
//  LocalNotificationManager.swift
//  ToDoList
//
//  Created by William Templeton on 3/6/20.
//  Copyright © 2020 William Templeton. All rights reserved.
//

import Foundation
import UserNotifications
import UIKit

struct LocalNotificationManager {
    static func authorizeLocalNotifications(viewController: UIViewController) {
          UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge,])  {(granted, error)
              in
              guard error == nil else {
                  print("🛑 ERROR \(error!.localizedDescription)")
                  return
              }
              if granted {
                  print("✅ Notifications Authorization Granted")
              } else {
                  print("🚫 User has denied Notifcations")
                DispatchQueue.main.async {
                    viewController.oneButtonAlert(title: "User Has Not Allowed Notifications", message: "To recieve alerts for reminders enable notifications. Go to Settings > To Do List > Notifications > Allow Notifications")
                }
              }
          }
      }
    
    static func isAuthorized(completed: @escaping (Bool)->()) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge,])  {(granted, error)
            in
            guard error == nil else {
                print("🛑 ERROR \(error!.localizedDescription)")
                completed(false)
                return
            }
            if granted {
                print("✅ Notifications Authorization Granted")
                completed(true)
            } else {
                print("📵 User has denied Notifcations")
                completed(false)
            }
        }
    }
    
    static func setCalendarNotifications(title: String, subtitle: String, body: String, badgeNumber: NSNumber?, sound: UNNotificationSound?, date: Date) -> String {
           // create content:
           let content = UNMutableNotificationContent()
           content.title = title
           content.subtitle = subtitle
           content.body = body
           content.sound = sound
           content.badge = badgeNumber
           
           // create trigger
           var dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: date)
           dateComponents.second = 00
           let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
           
           // create request
           let notificationID = UUID().uuidString
           let request = UNNotificationRequest(identifier: notificationID, content: content, trigger: trigger)
           
           // register request with notification center
           UNUserNotificationCenter.current().add(request) { (error) in
               if let error = error {
                   print("ERROR: \(error.localizedDescription)")
               } else {
                   print("Notification scheduled \(notificationID), title: \(content.title)")
               }
           }
           return notificationID
       }
    
    
}
