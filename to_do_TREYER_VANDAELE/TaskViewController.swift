//
//  TaskViewController.swift
//  to_do_TREYER_VANDAELE
//
//  Created by vandaele jason on 05/01/2021.
//  Copyright © 2021 treyer lucas. All rights reserved.
//

import UIKit
import MapKit

class TaskViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    @IBOutlet weak var taskInputName: UITextField!
    @IBOutlet weak var taskDate: UILabel!
    @IBOutlet weak var taskImage: UIImageView!
    @IBOutlet weak var taskLocalisation: MKMapView!
    @IBOutlet weak var taskLocalisationSwitch: UISwitch!
    
    var task: ToDoTask?
    
    var userLocalisation: CLLocation!
    
    let locationManager = CLLocationManager()
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        imagePicker.delegate = self
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        self.taskImage.isUserInteractionEnabled = true
        self.taskImage.addGestureRecognizer(tapGestureRecognizer)
        
        let mapTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(mapTapped(tapGestureRecognizer:)))
        self.taskLocalisation.addGestureRecognizer(mapTapGestureRecognizer)
        
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()

        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
        if let toDoTask = task {
            self.navigationItem.title = toDoTask.title
            self.taskInputName.text = toDoTask.title
            let dateFormatee = DateFormatter()
            dateFormatee.dateFormat = "HH:mm E, d MMM y"
            self.taskDate.text = dateFormatee.string(from: toDoTask.lastUpdateDate)
            if(toDoTask.photo != nil){ self.taskImage.image = toDoTask.photo }
            else{ self.taskImage.image = UIImage(named: "NoPhoto") }
            
            if let coordinates = toDoTask.localisation?.coordinate {
                let annotationPoint = MKPointAnnotation()
                annotationPoint.coordinate = coordinates
                annotationPoint.title = "Localisation"
                taskLocalisation.addAnnotation(annotationPoint)
            }
        }
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    @objc func mapTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let location = tapGestureRecognizer.location(in: taskLocalisation)
        let coordinate = taskLocalisation.convert(location, toCoordinateFrom: taskLocalisation)
        
        //task?.setLocalisation(localisation: CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude))
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        taskLocalisation.addAnnotation(annotation)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.taskImage.contentMode = .scaleAspectFit
            self.taskImage.image = pickedImage
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
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
        self.task!.photo = taskImage.image
        if(taskLocalisationSwitch.isOn){ self.task!.localisation = self.userLocalisation }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.userLocalisation = locationManager.location
        print(self.userLocalisation.coordinate.latitude)
        print(self.userLocalisation.coordinate.longitude)
    }
}
