//
//  FilteredList.swift
//  Bookworm
//
//  Created by Виктор on 21.06.2020.
//  Copyright © 2020 SwiftViktor. All rights reserved.
//

import SwiftUI
import CoreData


struct FilteredList<T: NSManagedObject, Content: View>: View {
    var fetchRequest: FetchRequest<T>
    var books: FetchedResults<T> { fetchRequest.wrappedValue }
    var sortDescriptors: [NSSortDescriptor]
    
    // this is our content closure; we'll call this once for each item in the list
    let content: (T) -> Content
    
    var body: some View {
        ForEach(fetchRequest.wrappedValue, id: \.self) { entity in
            self.content(entity)
        }
    }
    
    init(filterKey: String, filterValue: String, sortDescriptors: [NSSortDescriptor],  @ViewBuilder content: @escaping (T) -> Content) {
        self.sortDescriptors = sortDescriptors
        fetchRequest = FetchRequest<T>(entity: T.entity(),
                                       sortDescriptors: sortDescriptors,
                                       predicate: NSPredicate(format: "%K BEGINSWITH %@",
                                                              filterKey,
                                                              filterValue))
        self.content = content
    }
}


