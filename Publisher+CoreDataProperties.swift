//
//  Publisher+CoreDataProperties.swift
//  Bookworm
//
//  Created by Виктор on 21.06.2020.
//  Copyright © 2020 SwiftViktor. All rights reserved.
//
//

import Foundation
import CoreData


extension Publisher {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Publisher> {
        return NSFetchRequest<Publisher>(entityName: "Publisher")
    }

    @NSManaged public var name: String?
    @NSManaged public var book: NSSet?

}

// MARK: Generated accessors for book
extension Publisher {

    @objc(addBookObject:)
    @NSManaged public func addToBook(_ value: Book)

    @objc(removeBookObject:)
    @NSManaged public func removeFromBook(_ value: Book)

    @objc(addBook:)
    @NSManaged public func addToBook(_ values: NSSet)

    @objc(removeBook:)
    @NSManaged public func removeFromBook(_ values: NSSet)
    
    
    public var bookArray: [Book] {
        let set = book as? Set<Book> ?? []
        return set.sorted {
            $0.wrappedAuthor < $1.wrappedAuthor
        }
    }
}
