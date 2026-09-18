//
//  BookDetailView.swift
//  BookManager
//
//  Created by Jeremy Ru on 2026/9/18.
//

import SwiftUI

struct BookDetailView: View {
    var book: Book
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(book.title)
                .font(.title)
                .fontWeight(.black)
                .padding([.top], 40)
            
            Text("Author: \(book.author)")
                .font(.title3)
                .fontWeight(.bold)
                .padding(5)
            
            Text("Author Gender: \(book.gender)")
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(.secondary)
                .padding(20)
            
            Spacer()
        }
        .navigationBarTitle(Text("Book Details"), displayMode: .inline)
    }
}

#Preview {
    NavigationView {
        BookDetailView(book: Book(title: "1984", author: "George Orwell", gender: "Male", displayed: true))
    }
}
