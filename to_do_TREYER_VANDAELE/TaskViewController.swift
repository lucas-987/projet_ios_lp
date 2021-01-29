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
    var userLocalisationAnnotation: MKPointAnnotation?
    
    let locationManager = CLLocationManager()
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        imagePicker.delegate = self
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        self.taskImage.isUserInteractionEnabled = true
        self.taskImage.addGestureRecognizer(tapGestureRecognizer)
        
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
            self.taskDate.text = dateFormatee.string(from: toDoTask.lastUpdateDate!)
            
            if let photo = toDoTask.getPhoto() {
                self.taskImage.image = photo
            }
            else{
                self.taskImage.image = UIImage(named: "NoPhoto")
            }
            
            if let location = toDoTask.getLocation() {
                addAnnotation(location: location)
            }
        }
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
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
        
        if(sender.text!.isEmpty || sender.text!.trimmingCharacters(in: .whitespaces).isEmpty){
            
            saveButton.isEnabled = false
        }
        else {
            saveButton.isEnabled = true
        }
    }
    
    @IBAction func switchValueChanged(_ sender: UISwitch) {
        
        if(sender.isOn) {
            addAnnotation(location: userLocalisation)
        }
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
        
        if let image = taskImage.image {
            self.task!.setPhoto(photo: image)
        }
        
        if(taskLocalisationSwitch.isOn) {
            self.task!.setLocation(location: self.userLocalisation)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.userLocalisation = locationManager.location
        
        if(taskLocalisationSwitch.isOn) {
            if let localisationAnnotation = userLocalisationAnnotation {
                taskLocalisation.removeAnnotation(localisationAnnotation)
            }
            
            addAnnotation(location: userLocalisation)
        }
    }
    
    func addAnnotation(location: CLLocation) {
        let annotationPoint = MKPointAnnotation()
        
        annotationPoint.coordinate = location.coordinate
        annotationPoint.title = "Localisation"
        
        taskLocalisation.addAnnotation(annotationPoint)
        taskLocalisation.setCenter(location.coordinate, animated: true)
        userLocalisationAnnotation = annotationPoint
    }
}
