//
//  SimpleContactsApp.swift
//  SimpleContacts
//
//  Created by Jeremy Ru on 2026/10/7.
//

import SwiftUI
import SwiftData

@main
struct SimpleContactsApp: App {
    var body: some Scene {
        WindowGroup {
            AppView()
        }
        // Registers Person with a persistent container for the whole app
        .modelContainer(for: Person.self)
    }
}
