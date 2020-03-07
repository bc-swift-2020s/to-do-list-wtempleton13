//
//  ToDoItems.swift
//  ToDoList
//
//  Created by William Templeton on 3/6/20.
//  Copyright © 2020 William Templeton. All rights reserved.
//

import Foundation
import UserNotifications

class ToDoItems {
    var itemsArray: [ToDoItem] = []
    
    func saveData() {
        let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let documentURL = directoryURL.appendingPathComponent("todos")
            .appendingPathExtension("json")
        
        let jsonEncoder = JSONEncoder()
        let data = try? jsonEncoder.encode(itemsArray)
        do {
            try data?.write(to: documentURL, options: .noFileProtection)
        } catch {
            print("ERROR: DATA DID NOT SAVE \(error.localizedDescription)")
        }
        setNotifications()
    }
    
    func loadData(completed: @escaping ()->() ) {
        let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let documentURL = directoryURL.appendingPathComponent("todos")
            .appendingPathExtension("json")
        
        guard let data = try? Data(contentsOf: documentURL) else {return}
        let jsonDecoder = JSONDecoder()
        do {
            itemsArray = try jsonDecoder.decode(Array<ToDoItem>.self, from: data)
        } catch {
            print("ERROR: DATA DID NOT LOAD \(error.localizedDescription)")
        }
        completed()
    }
    
    func setNotifications() {
           guard itemsArray.count > 0 else {
               return
           }
           // remove all notifications
           UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
           
           // recreate with updated data
           for index in 0..<itemsArray.count {
               if itemsArray[index].reminderSet {
                   let toDoItem = itemsArray[index]
                itemsArray[index].notificationID = LocalNotificationManager.setCalendarNotifications(title: toDoItem.name, subtitle: "", body: toDoItem.notes, badgeNumber: nil, sound: .default, date: toDoItem.date)
                   
               }
           }
       }
}
