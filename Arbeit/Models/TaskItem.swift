//
//  TaskItem.swift
//  Arbeit
//
//  Created by Jeremy Ru on 2026/10/22.
//

import Foundation
import FirebaseFirestore

struct TaskItem: Identifiable, Comparable, Codable, Hashable {

    // MARK: Fields
    @DocumentID var id: String?
    var name: String
    var assignedTo: String
    var dueDate: Date
    var dateAdded: Date
    var completed: Bool

    // MARK: Codable
    enum CodingKeys: String, CodingKey {
        case id, name, assignedTo, dueDate, dateAdded, completed
    }

    // MARK: Comparable
    // Two tasks are equal when name, assignee, and due date match
    static func == (lhs: TaskItem, rhs: TaskItem) -> Bool {
        return lhs.name == rhs.name && lhs.assignedTo == rhs.assignedTo && lhs.dueDate == rhs.dueDate
    }

    // Tasks sort alphabetically by name.
    static func < (lhs: TaskItem, rhs: TaskItem) -> Bool {
        return lhs.name < rhs.name
    }
}

// MARK: - Validation
extension TaskItem {
    // Returns true only if both name and assignee are non-empty
    static func isValid(name: String, assignedTo: String) -> Bool {
        return !name.isEmpty && !assignedTo.isEmpty
    }
}
