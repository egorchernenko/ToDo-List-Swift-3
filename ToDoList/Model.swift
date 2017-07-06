//
//  Model.swift
//  ToDoList
//
//  Created by Egor on 06.07.17.
//  Copyright © 2017 Egor. All rights reserved.
//

import Foundation
import UIKit

struct Task{
    var string: String
    var check: Bool
}

class ToDoListDataBase {
    static var taskDataBase: [Task]?
    
    //load task from data base
    static func load() {
        if let tasks = UserDefaults.standard.value(forKey: "Tasks_DataBase") as? [Task]{
            ToDoListDataBase.taskDataBase = tasks
        }
    }
    
    //adding task to database
    static func add(task: Task){
        if (ToDoListDataBase.taskDataBase?.append(task) == nil){
            ToDoListDataBase.taskDataBase = [task]
            UserDefaults.standard.set(task, forKey: "Tasks_DataBase")
        }
        
    }
}

