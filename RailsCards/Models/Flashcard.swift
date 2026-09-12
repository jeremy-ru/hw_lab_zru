//
//  Flashcard.swift
//  RailsCards
//
//  Created by Jeremy Ru on 2026/9/10.
//

import Foundation

struct Flashcard {
    var command: String
    var definition: String

    init(command: String, definition: String) {
        self.command = command
        self.definition = definition
    }
}
