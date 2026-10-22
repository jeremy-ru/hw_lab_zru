//
//  TasksViewModel.swift
//  Arbeit
//
//  Created by Jeremy Ru on 2026/10/22.
//

import Foundation
import Observation

@Observable
class TasksViewModel {
    @ObservationIgnored private let repository: TaskRepository

    // Injects the repository (defaults to a fresh one) for testability
    init(repository: TaskRepository = TaskRepository()) {
        self.repository = repository
    }

    // Exposes the repository's tasks directly — it's the source of truth
    var tasks: [TaskItem] {
        repository.tasks
    }

    // Forwards a new task to the repository
    func add(_ task: TaskItem) {
        repository.create(task)
    }

    // Forwards an updated task to the repository
    func update(_ task: TaskItem) {
        repository.update(task)
    }

    // Forwards a deletion to the repository
    func destroy(_ task: TaskItem) {
        repository.delete(task)
    }
}
