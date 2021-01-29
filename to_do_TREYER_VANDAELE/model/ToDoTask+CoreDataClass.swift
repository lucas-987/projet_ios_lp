//
//  ToDoTask+CoreDataClass.swift
//  to_do_TREYER_VANDAELE
//
//  Created by treyer lucas on 26/01/2021.
//  Copyright © 2021 treyer lucas. All rights reserved.
//
//

import Foundation
import CoreData
import CoreLocation
import UIKit

@objc(ToDoTask)
public class ToDoTask: NSManagedObject {
    
    func getLocation() -> CLLocation? {
        //if let latitude = self.latitude, let longitude = self.longitude {
            return CLLocation(latitude: latitude, longitude: longitude)
        //}
        
    }
    
    func setLocation(location: CLLocation) {
        self.latitude = location.coordinate.latitude
        self.longitude = location.coordinate.longitude
    }
    
    func getPhoto() -> UIImage? {
        if let photo = self.photo {
            return UIImage(data: photo)
        }
        else {
            return nil
        }
    }
    
    func setPhoto(photo: UIImage) {
        self.photo = photo.pngData()
    }
}
