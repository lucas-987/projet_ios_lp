//
//  ToDoTask.swift
//  to_do_TREYER_VANDAELE
//
//  Created by vandaele jason on 05/01/2021.
//  Copyright © 2021 treyer lucas. All rights reserved.
//

import UIKit
import CoreLocation

class ToDoTask: NSObject {

    var title: String
    var state: Bool
    var lastUpdateDate: Date
    var photo: UIImage?
    var localisation: CLLocation?
    
    init(title: String, state: Bool) {
        self.title = title
        self.state = state
        self.lastUpdateDate = Date()
    }
    
    func setPhoto(photo: UIImage) {
        self.photo = photo
    }
    
    func setLocalisation(localisation: CLLocation) {
        self.localisation = localisation
    }
    
    static func loadSampleToDos() -> [ToDoTask]{
        let toDoTasks = [
            ToDoTask(title: "Faire les courses", state: true),
            ToDoTask(title: "Licencier Lucas Treyer", state: false),
            ToDoTask(title: "Noter ce projet 20/20", state: false)
        ]
        return toDoTasks;
    }
}

