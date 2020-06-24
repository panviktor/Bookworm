//
//  ContentView.swift
//  Bookworm
//
//  Created by Виктор on 19.06.2020.
//  Copyright © 2020 SwiftViktor. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    //    @FetchRequest(entity: Book.entity(), sortDescriptors:
    //        [NSSortDescriptor(keyPath: \Book.title, ascending: true),
    //         NSSortDescriptor(keyPath: \Book.author, ascending: true)]) var books: FetchedResults<Book>
    
    
    //    let pair = ["Apple", "Banana"]
    //    let predicateFilterAppleAndBanana = NSPredicate(format: "SELF IN %@", pair)
    //    let predicateFilterApple = NSPredicate(format: "SELF contains [cd] %@", "apple")
    //    let compoundPredicate = NSCompoundPredicate(
    //        andPredicateWithSubpredicates: [predicateFilterAppleAndBanana,
    //                                        predicateFilterApple])
    //    let compoundPredicateResult = names.filter(compoundPredicate.evaluate(with:))
    
    @State private var showingAddScreen = false
    @State private var ascendingToggle = true
    
    var sortDescriptors: [NSSortDescriptor] {
        [NSSortDescriptor(keyPath: \Book.title, ascending: ascendingToggle),
         NSSortDescriptor(keyPath: \Book.author, ascending: ascendingToggle)]
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Picker("", selection: $ascendingToggle) {
                    Image(systemName: "arrow.turn.left.up").tag(true)
                    Image(systemName: "arrow.turn.right.down").tag(false)
                }
                .pickerStyle(SegmentedPickerStyle())
                .cornerRadius(8)
                List {
                    FilteredList(filterKey: "author", filterValue: "A", sortDescriptors: sortDescriptors) { (book: Book) in
                        NavigationLink(destination: DetailView(book: book))  {
                            EmojiRatingView(rating: book.rating)
                                .font(.largeTitle)
                            VStack(alignment: .leading) {
                                Text(book.wrappedTitle)
                                    .font(.headline)
                                    .foregroundColor(book.rating == 1 ? .red : .primary)
                                
                                Text(book.wrappedAuthor)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                
                }
            }
                
            .navigationBarTitle("Booworm")
            .navigationBarItems(leading: EditButton(), trailing: Button(action: {
                self.showingAddScreen.toggle()
            }) {   Image(systemName: "plus")
            })
                .sheet(isPresented: $showingAddScreen) {
                    AddBookView().environment(\.managedObjectContext, self.moc)
            }
        }
    }
}

//private func deletedBooks(at offsets: IndexSet) {
//    for offset in offsets {
//        let book = books[offset]
//        moc.delete(book)
//    }
//    try? moc.save()
//}

