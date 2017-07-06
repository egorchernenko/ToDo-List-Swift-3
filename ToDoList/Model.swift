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
    static func load() -> [Task]? {
        if let data = UserDefaults.standard.data(forKey: "Tasks_DataBase"),
        let tasksDB = NSKeyedUnarchiver.unarchiveObject(with: data) as? [Task]?{
            taskDataBase = tasksDB
        } else {
            print("There is an issue 1")
        }
        return taskDataBase
    }
    
    //adding task to database
    static func add(task: Task){
        if (ToDoListDataBase.taskDataBase?.append(task) == nil){
            ToDoListDataBase.taskDataBase = [task]
        }
        
        if let toDoListDB = ToDoListDataBase.taskDataBase{
            let encodedData = NSKeyedArchiver.archivedData(withRootObject: toDoListDB)
            UserDefaults.standard.set(encodedData, forKey: "Tasks_DataBase")
        } else{
            print("There is an issue 2")
        }
    }
}



