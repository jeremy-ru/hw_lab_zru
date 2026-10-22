//
//  TaskRepository.swift
//  Arbeit
//
//  Created by Jeremy Ru on 2026/10/22.
//

import Foundation
import Observation
import FirebaseFirestore

@Observable
class TaskRepository {
    @ObservationIgnored private let path: String = "tasks"
    @ObservationIgnored private let store = Firestore.firestore()
    @ObservationIgnored private var listener: ListenerRegistration?

    var tasks: [TaskItem] = []

    // Starts the real-time listener as soon as the repository is created
    init() {
        self.get()
    }

    // Detaches the Firestore listener when the repository goes away
    deinit {
        listener?.remove()
    }

    // Attaches a snapshot listener that keeps `tasks` in sync with Firestore
    func get() {
        listener = store.collection(path)
            .order(by: "name")
            .addSnapshotListener { [weak self] snapshot, error in
                guard let self = self, let snapshot = snapshot else {
                    if let error = error {
                        print("Error fetching tasks: \(error.localizedDescription)")
                    }
                    return
                }
                self.tasks = snapshot.documents.compactMap { doc in
                    try? doc.data(as: TaskItem.self)
                }
            }
    }

    // Adds a new task document to Firestore
    func create(_ task: TaskItem) {
        do {
            _ = try store.collection(path).addDocument(from: task)
        } catch {
            print("Error adding task: \(error.localizedDescription)")
        }
    }

    // Overwrites the matching document with the updated task
    func update(_ task: TaskItem) {
        guard let id = task.id else { return }
        do {
            try store.collection(path).document(id).setData(from: task, merge: true)
        } catch {
            print("Error updating task: \(error.localizedDescription)")
        }
    }

    // Deletes the task's document from Firestore
    func delete(_ task: TaskItem) {
        guard let id = task.id else { return }
        store.collection(path).document(id).delete { error in
            if let error = error {
                print("Error deleting task: \(error.localizedDescription)")
            }
        }
    }
}
