//
//  TaskModel.swift
//  net360
//
//  Created by Arben on 23.7.24.
//

import Foundation

struct Task: Identifiable{
    var id = UUID().uuidString
    var taskTitle: String
    var taskDescription: String
    var taskDate: Date
}
