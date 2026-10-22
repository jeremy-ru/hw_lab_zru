//
//  TaskDetailsView.swift
//  Arbeit
//
//  Created by Jeremy Ru on 2026/10/22.
//

import SwiftUI

struct TaskDetailsView: View {
    // The specific task we are viewing/editing, passed in from the navigation link
    let task: TaskItem
    
    // Access to the shared ViewModel (to save changes)
    @Environment(TasksViewModel.self) private var viewModel
    // Access to the dismiss action (to close the view after saving/deleting)
    @Environment(\.dismiss) private var dismiss

    // MARK: - State
    // Use local @State variables to hold the *edited* values before they are saved
    @State private var name: String
    @State private var assignedTo: String
    @State private var dueDate: Date
    @State private var completed: Bool
    
    // UI state for alerts and dialogs.
    @State private var showingAlert = false
    @State private var showingDeleteConfirmation = false

    // MARK: - Custom Initializer
    init(task: TaskItem) {
        self.task = task
        _name = State(initialValue: task.name)
        _assignedTo = State(initialValue: task.assignedTo)
        _dueDate = State(initialValue: task.dueDate)
        _completed = State(initialValue: task.completed)
    }

    // MARK: - Body
    var body: some View {
        Form {
            // Section 1: Editable fields
            Section(header: Text("Task Details")) {
                TextField("Task Name", text: $name)
                TextField("Assigned To", text: $assignedTo)
                DatePicker("Due Date", selection: $dueDate, displayedComponents: .date)
                
                // Native iOS toggle switch
                Toggle("Completed", isOn: $completed)
            }

            // Section 2: Read-only info
            Section(header: Text("Metadata")) {
                HStack {
                    Text("Date Added")
                    Spacer() // Pushes the text to the left and the date to the right
                    Text(task.dateAdded, style: .date)
                        .foregroundColor(.secondary)
                }
            }

            // Section 3: Destructive action
            Section {
                Button("Delete Task", role: .destructive) {
                    // Tapping this doesn't delete immediately; it shows a confirmation dialog.
                    showingDeleteConfirmation = true
                }
            }
        }
        .navigationTitle("Task Details")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Save") { saveTask() }
            }
        }
        // Standard Alert for validation
        .alert("Validation Error", isPresented: $showingAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("Please enter both name and assignee")
        }
        // Confirmation Dialog (Action Sheet) for deleting
        .confirmationDialog("Delete Task", isPresented: $showingDeleteConfirmation) {
            Button("Delete", role: .destructive) {
                viewModel.destroy(task)
                dismiss() // Close the view after deleting
            }
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Are you sure you want to delete this task?")
        }
    }

    // MARK: - Functions
    
    /// Validates edits and pushes the updated task through the ViewModel.
    private func saveTask() {
        // Ensure they didn't erase the text fields
        guard TaskItem.isValid(name: name, assignedTo: assignedTo) else {
            showingAlert = true
            return
        }
        
        // Start with the original task (to keep the ID and dateAdded)
        var updated = task
        
        // Apply the new values
        updated.name = name
        updated.assignedTo = assignedTo
        updated.dueDate = dueDate
        updated.completed = completed
        
        // Send to ViewModel and close the screen
        viewModel.update(updated)
        dismiss()
    }
}
