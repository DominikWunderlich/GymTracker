//
//  Persistence.swift
//  GymTracker
//
//  Created by Dominik Wunderlich on 19.08.25.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    let container: NSPersistentContainer
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "GymTrackerModel")
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Core Data Error: \(error), \(error.userInfo)")
            }
        }
    }
}
