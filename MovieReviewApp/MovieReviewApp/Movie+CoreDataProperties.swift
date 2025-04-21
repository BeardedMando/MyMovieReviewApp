//
//  Movie+CoreDataProperties.swift
//  MovieReviewApp
//
//  Created by German Bojorge on 4/20/25.
//
//

import Foundation
import CoreData


extension Movie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movie> {
        return NSFetchRequest<Movie>(entityName: "Movie")
    }

    @NSManaged public var date: Date?
    @NSManaged public var rating: Double
    @NSManaged public var review: String?
    @NSManaged public var name: String?

}

extension Movie : Identifiable {

}
