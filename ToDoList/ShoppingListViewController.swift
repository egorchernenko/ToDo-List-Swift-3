//
//  ShoppingListViewController.swift
//  ToDoList
//
//  Created by Egor on 02.07.17.
//  Copyright © 2017 Egor. All rights reserved.
//

import UIKit

class ShoppingListViewController: UIViewController {
    
    var shoppingListArray: [String]?

    @IBOutlet weak var shoppingListTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let items = UserDefaults.standard.value(forKey: "ShoppingList_STORAGE") as? [String]{
            shoppingListArray = items
        }
        tableView.reloadData()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            shoppingListArray?.remove(at: indexPath.row)
            UserDefaults.standard.set(shoppingListArray, forKey: "ShoppingList_STORAGE")
        }
        tableView.reloadData()
    }

}

extension ShoppingListViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ShoppingListTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ShoppingListTabelViewcellIndetifier", for: indexPath) as! ShoppingListTableViewCell
        cell.shoppingListLabel.text = "test"
        
        return cell
    }
}

extension ShoppingListViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let str = textField.text{
            if str.characters.count > 0 {
                if (shoppingListArray?.append(str)) == nil{
                    shoppingListArray = [str]
                }
                UserDefaults.standard.set(shoppingListArray, forKey: "ShoppingList_STORAGE")
            }
        }
        
        
        shoppingListTextField.text = ""
        shoppingListTextField.resignFirstResponder()
        tableView.reloadData()
        return true
    }
}
