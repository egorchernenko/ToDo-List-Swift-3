//
//  CompletedViewController.swift
//  ToDoList
//
//  Created by Egor on 01.07.17.
//  Copyright © 2017 Egor. All rights reserved.
//

import UIKit

class CompletedViewController: UIViewController {

    
    // MARK: - Properties
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let items = UserDefaults.standard.value(forKey: "toDoList_Completed_Task_STORAGE") as? [String]{
            completed = items
        }
        self.tableView.reloadData()
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            completed?.remove(at: indexPath.row)
            UserDefaults.standard.set(completed, forKey: "toDoList_Completed_Task_STORAGE")
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
    
    

}

extension CompletedViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return completed?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CompletedTableViewCell = tableView.dequeueReusableCell(withIdentifier: "CompletedTableViewCellIdentifier", for: indexPath) as! CompletedTableViewCell
        cell.completedCellLabel.text = completed?[indexPath.row]
        
        return cell
    }
}

