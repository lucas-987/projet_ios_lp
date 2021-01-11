//
//  TaskViewController.swift
//  to_do_TREYER_VANDAELE
//
//  Created by vandaele jason on 05/01/2021.
//  Copyright © 2021 treyer lucas. All rights reserved.
//

import UIKit
import MapKit

class TaskViewController: UIViewController {

    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    @IBOutlet weak var taskInputName: UITextField!
    @IBOutlet weak var taskDate: UILabel!
    @IBOutlet weak var taskImage: UIImageView!
    @IBOutlet weak var taskLocalisationSwitch: UISwitch!
    @IBOutlet weak var taskLocalisation: MKMapView!
    
    var task: ToDoTask?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let toDoTask = task {
            self.navigationItem.title = toDoTask.title
            taskInputName.text = toDoTask.title
            let dateFormatee = DateFormatter()
            dateFormatee.dateFormat = "HH:mm E, d MMM y"
            taskDate.text = dateFormatee.string(from: toDoTask.lastUpdateDate)
            if(toDoTask.photo != nil){ taskImage.image = toDoTask.photo }
            if(toDoTask.localisation != nil){
                //Faire des trucs pour afficher l bon endroit sur la carte
            }
        }
    }
    
    @IBAction func cancelButtonClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func textEditingChanged(_ sender: Any) {
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
