//
//  ToDoListViewController.swift
//  ToDoList
//
//  Created by Egor on 28.06.17.
//  Copyright © 2017 Egor. All rights reserved.
//

import UIKit



class ToDoListViewController: UIViewController {

    
    // MARK: - Propeties
    
    var toDoListDB: [Task]?
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet fileprivate weak var tableView: UITableView!
    @IBOutlet fileprivate weak var addItemTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        toDoListDB = ToDoListDataBase.load()
        tableView.reloadData()
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

// MARK: -
extension ToDoListViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoListDB?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ToDoListTableViewCell = tableView.dequeueReusableCell(withIdentifier: "toDoListCellIdentifier", for: indexPath) as! ToDoListTableViewCell
        cell.itemLabel.text = toDoListDB?[indexPath.row].string
        return cell
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) { //убираем клавиатуру когда начинаем скролить
        addItemTextField.resignFirstResponder()
    }
    
    //height of header view after text field
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
        return CGFloat(20.0)
    }
    
    //put checkmark if it selected
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.cellForRow(at: indexPath)?.accessoryType == UITableViewCellAccessoryType.checkmark{
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.none
            ToDoListDataBase.taskDataBase?[indexPath.row].check = false //!!!!!!
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.checkmark
            ToDoListDataBase.taskDataBase?[indexPath.row].check = true //!!!!!!!
        }
    }
}


    //delete
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            //ToDoListDataBase.taskDataBase?.remove(at: indexPath.row) !!!!!!
            //UserDefaults.standard.set(arr, forKey: "ToDoList_STORAGE") !!!!!
        }
        tableView.reloadData()
    }


// MARK: -
extension ToDoListViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let str = textField.text{
            if str.characters.count > 0 {
                ToDoListDataBase.add(task: Task(string: str, check: false))
                toDoListDB = ToDoListDataBase.load()
            }
        }
        
        
        addItemTextField.text = ""
        addItemTextField.resignFirstResponder()
        tableView.reloadData()
        return true
    }
}
