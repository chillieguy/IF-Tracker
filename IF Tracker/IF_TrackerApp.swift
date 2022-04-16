//
//  IF_TrackerApp.swift
//  IF Tracker
//
//  Created by Chuck Underwood on 11/21/21.
//

import SwiftUI
import CoreData

@main
struct IF_TrackerApp: App {
    
    let persistentContainer = CoreDataManager.shared.persistentContainer
    
    var body: some Scene {
        WindowGroup {
            MainView().environment(\.managedObjectContext, persistentContainer.viewContext)
        }
    }
}
