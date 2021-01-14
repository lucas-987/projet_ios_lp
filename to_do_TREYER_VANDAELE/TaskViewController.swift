//
//  TaskViewController.swift
//  to_do_TREYER_VANDAELE
//
//  Created by vandaele jason on 05/01/2021.
//  Copyright © 2021 treyer lucas. All rights reserved.
//

import UIKit
import MapKit

class TaskViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    @IBOutlet weak var taskInputName: UITextField!
    @IBOutlet weak var taskDate: UILabel!
    @IBOutlet weak var taskImage: UIImageView!
    @IBOutlet weak var taskLocalisationSwitch: UISwitch!
    @IBOutlet weak var taskLocalisation: MKMapView!
    
    var task: ToDoTask?
    var locationManager:CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        if let toDoTask = task {
            self.navigationItem.title = toDoTask.title
            taskInputName.text = toDoTask.title
            let dateFormatee = DateFormatter()
            dateFormatee.dateFormat = "HH:mm E, d MMM y"
            taskDate.text = dateFormatee.string(from: toDoTask.lastUpdateDate)
            if(toDoTask.photo != nil){ taskImage.image = toDoTask.photo }
            else{ taskImage.image = UIImage(named: "NoPhoto") }
            if(toDoTask.localisation != nil){
                
            }
        }
    }
    
    @IBAction func cancelButtonClicked(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
        //dismiss(animated: true, completion: nil)
    }
    
    @IBAction func textEditingChanged(_ sender: UITextField) {
        if(sender.text!.isEmpty || sender.text!.trimmingCharacters(in: .whitespaces).isEmpty){ saveButton.isEnabled = false }
        else { saveButton.isEnabled = true }
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() { view.endEditing(true) }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        self.task!.title = taskInputName.text!
        self.task!.lastUpdateDate = Date()
    }

}
