//
//  NewBookView.swift
//  BookManager
//
//  Created by Jeremy Ru on 2026/9/18.
//

import SwiftUI

struct NewBookView: View {
    @EnvironmentObject var library: Library
    
    @State private var title = ""
    @State private var author = ""
    @State private var gender = "Male"
    @State private var displayed = false
    
    var body: some View {
        VStack {
            Text("New Book")
                .font(.title)
                .fontWeight(.bold)
            
            Form {
                TextField("Title", text: $title)
                TextField("Author", text: $author)
                
                Picker(selection: $gender, label: Text("Author Gender")) {
                    ForEach(Gender.allGenders, id: \.self) { g in
                        Text(g).tag(g)
                    }
                }
                
                Toggle(isOn: $displayed, label: {
                    Text("Display book in library")
                })
                
                Button("Add Book") {
                    library.addBookToLibrary(
                        title: title,
                        author: author,
                        gender: gender,
                        displayed: displayed
                    )
                    
                    title = ""
                    author = ""
                    gender = "Male"
                    displayed = false
                }
                .fontWeight(.bold)
                .disabled(title.isEmpty || author.isEmpty)
            }
        }
        .padding()
    }
}

#Preview {
    NewBookView()
        .environmentObject(Library())
}
