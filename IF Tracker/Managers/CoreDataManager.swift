//
//  CoreDataManager.swift
//  IF Tracker
//
//  Created by Chuck Underwood on 4/10/22.
//

import Foundation
import CoreData

class CoreDataManager {
    
    // Setup Coredata persistance
    let persistentContainer: NSPersistentContainer
    // Use global variable to store Coredata manager
    static let shared: CoreDataManager = CoreDataManager()
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "IFFastModel")
        persistentContainer.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Unable to initialize Core Data: \(error)")
            }
        }
    }
}
