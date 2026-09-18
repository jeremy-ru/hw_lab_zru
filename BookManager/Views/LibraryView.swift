//
//  LibraryView.swift
//  BookManager
//
//  Created by Jeremy Ru on 2026/9/18.
//

import SwiftUI

struct LibraryView: View {
    @EnvironmentObject var library: Library
    
    var body: some View {
        NavigationView {
            List {
                ForEach(library.books) { book in
                    BookRowView(book: book)
                }
                .onDelete(perform: removeRows)
            }
            .navigationBarTitle("Library")
        }
    }
    
    func removeRows(at offsets: IndexSet) {
        library.books.remove(atOffsets: offsets)
    }
}

#Preview {
    LibraryView()
        .environmentObject(Library())
}
