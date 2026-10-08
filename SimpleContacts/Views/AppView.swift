//
//  AppView.swift
//  SimpleContacts
//
//  Created by Jeremy Ru on 2026/10/7.
//

import SwiftUI
import SwiftData

struct AppView: View {
    @Environment(\.modelContext) var modelContext  // Used in addPerson()
    @State private var path = [Person]()           // Drives NavigationStack
    @State private var searchText = ""             // Bound to .searchable
    @State private var sortOrder = [SortDescriptor(\Person.name)]  // Default: A-Z

    var body: some View {
        NavigationStack(path: $path) {
            PeopleView(searchString: searchText, sortOrder: sortOrder)
                .navigationTitle("My Contacts")
                // Tells the stack which view to push for a Person value
                .navigationDestination(for: Person.self) { person in
                    EditPersonView(person: person)
                }
                .toolbar {
                    // Sort picker (ascending / descending by name)
                    Menu("Sort", systemImage: "arrow.up.arrow.down") {
                        Picker("Sort", selection: $sortOrder) {
                            Text("Name (A-Z)")
                                .tag([SortDescriptor(\Person.name)])
                            Text("Name (Z-A)")
                                .tag([SortDescriptor(\Person.name, order: .reverse)])
                        }
                    }
                    Button("Add Person", systemImage: "plus", action: addPerson)
                }
                .searchable(text: $searchText)
        }
    }

    // Inserts a blank Person and pushes the editor
    func addPerson() {
        let person = Person(name: "", email: "", details: "")
        modelContext.insert(person)
        path.append(person)
    }
}
