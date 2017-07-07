//
//  Model.swift
//  ToDoList
//
//  Created by Egor on 06.07.17.
//  Copyright © 2017 Egor. All rights reserved.
//

import Foundation
import UIKit

class Task: NSObject, NSCoding{
    
    var string: String
    var check: Bool = false

    init(string: String, check: Bool) {
        self.string = string
        self.check = check
    }
    
    required init(coder decoder:NSCoder) {
        self.string = decoder.decodeObject(forKey: "string") as? String ?? ""
        self.check = decoder.decodeBool(forKey: "check")
    }
    func encode(with aCoder: NSCoder) {
        aCoder.encode(string, forKey: "string")
        aCoder.encode(check, forKey: "check")
    }
    
}


class ToDoListDataBase {
    static var taskDataBase: [Task]?
    
    //func for setting data to user defaults
    private static func setTaskDataBaseToUserDefaults(key: String, dataBase: [Task]?){
        if let toDoListDB = dataBase{
            let encodedData = NSKeyedArchiver.archivedData(withRootObject: toDoListDB)
            UserDefaults.standard.set(encodedData, forKey: key)
        }
    }
    
    //func or loading data from user defualts
    private static func loadTaskDataBaseFromUserDefualts(key: String){
        if let data = UserDefaults.standard.data(forKey: "Tasks_DataBase"),
            let tasksDB = NSKeyedUnarchiver.unarchiveObject(with: data) as? [Task]?{
            taskDataBase = tasksDB
        }
    }
    
    //MARK: - Main functions
    //load task from data base
    static func load() -> [Task]?
    {
        loadTaskDataBaseFromUserDefualts(key: "Tasks_DataBase")
        
        return taskDataBase
    }
    
    //adding task to database
    static func add(task: Task)
    {
        if (ToDoListDataBase.taskDataBase?.append(task) == nil){
            ToDoListDataBase.taskDataBase = [task]
        }
        
        setTaskDataBaseToUserDefaults(key: "Tasks_DataBase", dataBase: ToDoListDataBase.taskDataBase)
    }
    
    //delete from database
    static func delete(at index: Int)
    {
        ToDoListDataBase.taskDataBase?.remove(at: index)
        
        setTaskDataBaseToUserDefaults(key: "Tasks_DataBase", dataBase: ToDoListDataBase.taskDataBase)
    }
    
    static func isCheck(at index: Int, state: Bool)
    {
        ToDoListDataBase.taskDataBase?[index].check = state
        
        setTaskDataBaseToUserDefaults(key: "Tasks_DataBase", dataBase: ToDoListDataBase.taskDataBase)

    }
    
    //MARK: - Completed data base 
    //TODO: -
    static var completedTaskDataBase: [Task]?
    
    
    
}


