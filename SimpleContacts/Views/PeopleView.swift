//
//  PeopleView.swift
//  SimpleContacts
//
//  Created by Jeremy Ru on 2026/10/7.
//

import SwiftUI
import SwiftData

struct PeopleView: View {
    @Environment(\.modelContext) var modelContext  // Used in deletePeople()
    @Query var people: [Person]                    // Replaced in init below

    var body: some View {
        List {
            ForEach(people) { person in
                NavigationLink(value: person) {
                    // Fallback label for blank "New Person" rows.
                    Text(person.name.isEmpty ? "New Person" : person.name)
                }
            }
            .onDelete(perform: deletePeople)
        }
    }

    // Custom init so we can build a filtered + sorted @Query
    init(searchString: String = "", sortOrder: [SortDescriptor<Person>] = []) {
        // _people reaches into the property wrapper's storage directly
        _people = Query(
            filter: #Predicate { person in
                if searchString.isEmpty {
                    true
                } else {
                    person.name.localizedStandardContains(searchString)
                }
            },
            sort: sortOrder
        )
    }

    func deletePeople(at offsets: IndexSet) {
        for offset in offsets {
            modelContext.delete(people[offset])
        }
    }
}
