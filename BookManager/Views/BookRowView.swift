//
//  BookRowView.swift
//  BookManager
//
//  Created by Jeremy Ru on 2026/9/18.
//

import SwiftUI

struct BookRowView: View {
    var book: Book
    
    var body: some View {
        NavigationLink(
            destination: BookDetailView(book: book),
            label: {
                Text(book.title)
                    .fontWeight(.bold)
            }
        )
    }
}
