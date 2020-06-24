//
//  Book+CoreDataProperties.swift
//  Bookworm
//
//  Created by Виктор on 21.06.2020.
//  Copyright © 2020 SwiftViktor. All rights reserved.
//
//

import Foundation
import CoreData


extension Book {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Book> {
        return NSFetchRequest<Book>(entityName: "Book")
    }

    @NSManaged public var author: String?
    @NSManaged public var endDate: Date?
    @NSManaged public var genre: String?
    @NSManaged public var id: UUID?
    @NSManaged public var rating: Int16
    @NSManaged public var review: String?
    @NSManaged public var startDate: Date?
    @NSManaged public var title: String?
    @NSManaged public var origin: Publisher?

}

extension Book {
    public var wrappedAuthor: String {
        author ?? "Unknown Author"
    }
    
    public var wrappedEndDate: Date {
        endDate ?? Date()
    }
    
    public var wrappedGenre: String {
        genre ?? "Unknown Genre"
    }
    
    public var wrappedReview: String {
        review ?? "Unknown Review"
    }
    
    public var wrappedStartDate: Date {
        startDate ?? Date()
    }
    
    public var wrappedTitle: String {
        title ?? "Unknown Title"
    }
}
