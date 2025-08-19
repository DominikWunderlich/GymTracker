//
//  GymTrackerApp.swift
//  GymTracker
//
//  Created by Dominik Wunderlich on 20.07.25.
//

import SwiftUI

@main
struct GymTrackerApp: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
        }
    }
}
