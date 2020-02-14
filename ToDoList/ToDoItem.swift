//
//  ToDoItem.swift
//  ToDoList
//
//  Created by William Templeton on 2/10/20.
//  Copyright © 2020 William Templeton. All rights reserved.
//

import Foundation

struct ToDoItem: Codable {
    var name: String
    var date: Date
    var notes: String
    var reminderSet: Bool
}


