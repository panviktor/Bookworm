//
//  DetailView.swift
//  Bookworm
//
//  Created by Виктор on 19.06.2020.
//  Copyright © 2020 SwiftViktor. All rights reserved.
//

import SwiftUI
import CoreData

struct DetailView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    @State private var showingDeleteAlert = false
    
    @ObservedObject var book: Book
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                ZStack(alignment: .bottomTrailing) {
                    Image(self.book.wrappedGenre)
                        .frame(maxWidth: geometry.size.width)
                    
                    Text(self.book.wrappedGenre.uppercased())
                        .font(.caption)
                        .fontWeight(.black)
                        .padding(15)
                        .foregroundColor(.white)
                        .background(Color.black.opacity(0.75))
                        .clipShape(Capsule())
                        .offset(x: -5, y: -5)
                }
                Text(self.book.wrappedAuthor)
                    .font(.title)
                    .foregroundColor(.secondary)
                
//                Button("ADD TEXT") {
//                    self.book.author! += "TEXT"
//                }
                
                Text(self.book.wrappedReview)
                    .padding()
                
                Group {
                    Text("Start date of reading the book: \(self.book.wrappedStartDate, formatter: self.dateFormatter)")
                        .padding()
                    Text("End date of reading the book: \(self.book.wrappedEndDate, formatter: self.dateFormatter)")
                        .padding(.bottom)
                }
                .font(.footnote)
                .frame(maxWidth: .infinity)
                .background(Color.gray.opacity(0.3))
                
                RatingView(rating: .constant(Int(self.book.rating)))
                    .font(.largeTitle)
                Spacer()
            }
            
        }
        .alert(isPresented: $showingDeleteAlert) {
            Alert(title: Text("Delete book"),
                  message: Text("Are you sure?"),
                  primaryButton: .destructive(Text("Delete")) {
                    self.deleteBook()
                }, secondaryButton: .cancel()
            )}
            .navigationBarTitle(Text(book.wrappedTitle), displayMode: .inline)
            .navigationBarItems(
                leading:  Text("Edit")
                
                ,
                trailing: Button(action: {
                    self.showingDeleteAlert = true
                }) {
                    Image(systemName: "trash")
            })
            .onDisappear {
                if self.moc.hasChanges {
                    try? self.moc.save()
                }
        }
    }
    
    private func deleteBook() {
        moc.delete(book)
        
        try? self.moc.save()
        presentationMode.wrappedValue.dismiss()
    }
}

struct DetailView_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    
    static var previews: some View {
        let book = Book(context: moc)
        book.title = "Test book"
        book.author = "Test author"
        book.genre = "Fantasy"
        book.review = "This was a great book; I really enjoyed it."
        book.startDate = Date()
        book.endDate = Date()
        book.rating = 4
        
        return NavigationView {
            DetailView(book: book)
        }
    }
}


