//
//  ToDoTask+CoreDataProperties.swift
//  to_do_TREYER_VANDAELE
//
//  Created by treyer lucas on 28/01/2021.
//  Copyright © 2021 treyer lucas. All rights reserved.
//
//

import Foundation
import CoreData


extension ToDoTask {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDoTask> {
        return NSFetchRequest<ToDoTask>(entityName: "ToDoTask")
    }

    @NSManaged public var lastUpdateDate: Date?
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var photo: Data?
    @NSManaged public var state: Bool
    @NSManaged public var title: String?

}

extension ToDoTask : Identifiable {

}
