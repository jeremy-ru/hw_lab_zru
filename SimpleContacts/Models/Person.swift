//
//  Person.swift
//  SimpleContacts
//
//  Created by Jeremy Ru on 2026/10/7.
//

import Foundation
import SwiftData

@Model
class Person {
    var name: String
    var email: String
    var details: String

    // Stored outside the sqlite DB (on disk) since photos are large
    @Attribute(.externalStorage) var photo: Data?

    init(name: String, email: String, details: String, photo: Data? = nil) {
        self.name = name
        self.email = email
        self.details = details
        self.photo = photo
    }
}
