//
//  TodoTableViewController.swift
//  to_do_TREYER_VANDAELE
//
//  Created by treyer lucas on 04/01/2021.
//  Copyright © 2021 treyer lucas. All rights reserved.
//

import UIKit

class TodoTableViewController: UITableViewController {
    
    @IBOutlet weak var addTodoTextField: UITextField!
    var tasks = [ToDoTask]()

    @IBAction func addTodoTextFieldEntered(_ sender: UITextField) {
        if(sender.text!.isEmpty || sender.text!.trimmingCharacters(in: .whitespaces).isEmpty){
            let alert = UIAlertController(title: "Erreur", message: "Veuillez entrer un nom pour la tâche", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
            }))
            self.present(alert, animated: true, completion: nil)
        }
        else{
            tasks.append(ToDoTask(title: sender.text!, state: false))
            sender.resignFirstResponder()
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        tasks = ToDoTask.loadSampleToDos()
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoTaskCell", for: indexPath) as! TodoTableViewCell
        let task = tasks[indexPath.row]
        cell.todoTitleLabel.text = task.title
        cell.toDoTask = task
        if(task.state == true){cell.todoButtonDone.setTitle("Done", for: [])}
        else{cell.todoButtonDone.setTitle("Not done", for: [])}
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if(tasks[indexPath.row].state == true){
                tasks.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            else{
                let alert = UIAlertController(title: "Erreur", message: "La tâche n'est pas terminée, elle ne peut pas être effacée", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                NSLog("The \"OK\" alert occured.")
                }))
                self.present(alert, animated: true, completion: nil)
            }
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    @IBAction func unwindToToDoList(segue: UIStoryboardSegue){
        let taskview = segue.source as! TaskViewController
        let task = taskview.task
        let selectedIndexPath = tableView.indexPathForSelectedRow!
        tasks[selectedIndexPath.row] = task!
        tableView.reloadRows(at: [selectedIndexPath], with: .none)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let selectedIndexPath = tableView.indexPathForSelectedRow!
        let selectedTask = tasks[selectedIndexPath.row]
        let detailTask = segue.destination as! TaskViewController
        detailTask.task = selectedTask
    }

}
