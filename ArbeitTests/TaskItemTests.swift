//
//  TaskItemTests.swift
//  Arbeit
//
//  Created by Jeremy Ru on 2026/10/22.
//

import Testing
import Foundation
// @testable allows us to access internal code from the main app module
@testable import Arbeit

// We use @MainActor to match how SwiftUI manages state on the main thread
@MainActor
struct TaskItemTests {

    // A fixed date prevents tests from failing due to tiny millisecond differences
    // between two Date() calls
    private nonisolated static let fixedDate = Date(timeIntervalSince1970: 1_700_000_000)

    /// Builds a deterministic sample task for tests.
    private func sample(name: String = "Write lab",
                        assignedTo: String = "Prof H",
                        dueDate: Date = TaskItemTests.fixedDate) -> TaskItem {
        TaskItem(
            name: name,
            assignedTo: assignedTo,
            dueDate: dueDate,
            dateAdded: TaskItemTests.fixedDate,
            completed: false
        )
    }

    // Empty names must fail validation
    @Test func validationRejectsEmptyName() {
        #expect(TaskItem.isValid(name: "", assignedTo: "someone") == false)
    }

    // Empty assignees must fail validation
    @Test func validationRejectsEmptyAssignee() {
        #expect(TaskItem.isValid(name: "something", assignedTo: "") == false)
    }

    // Valid input must pass validation
    @Test func validationAcceptsBothPresent() {
        #expect(TaskItem.isValid(name: "something", assignedTo: "someone") == true)
    }

    // Equality ignores id and completion status
    @Test func equalityIgnoresIdAndCompletion() {
        var a = sample()
        var b = sample()
        
        // Modify properties that shouldn't affect equality
        a.id = "abc"
        b.id = "xyz"
        b.completed = true
        
        // They should still be considered equal because name, assignee, and dueDate match
        #expect(a == b)
    }

    // Sorting orders tasks alphabetically by name
    @Test func sortsByName() {
        let apple = sample(name: "Apple")
        let banana = sample(name: "Banana")
        let cherry = sample(name: "Cherry")
        
        // Start with a scrambled array, then sort it
        let sorted = [cherry, apple, banana].sorted()
        
        // Verify the alphabetical order is correct
        #expect(sorted.map(\.name) == ["Apple", "Banana", "Cherry"])
    }
}
