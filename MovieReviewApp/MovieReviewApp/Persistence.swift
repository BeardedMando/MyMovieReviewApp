//
//  Persistence.swift
//  MovieReviewApp
//
//  Created by German Bojorge on 4/20/25.
//

import CoreData

// Persistence Controller for Core Data
struct PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentContainer

    init() {
        container = NSPersistentContainer(name: "MovieReviewApp")
        container.loadPersistentStores { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
}
