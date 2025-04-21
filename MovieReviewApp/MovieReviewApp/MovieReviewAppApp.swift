//
//  MovieReviewAppApp.swift
//  MovieReviewApp
//
//  Created by German Bojorge on 4/20/25.
//

import SwiftUI
import CoreData

@main
struct MovieReviewAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
