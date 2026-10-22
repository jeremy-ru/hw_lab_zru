//
//  NewTaskView.swift
//  Arbeit
//
//  Created by Jeremy Ru on 2026/10/22.
//

import SwiftUI

struct NewTaskView: View {
    // MARK: - Environment
    // Gives us access to the presentation context so we can close the sheet
    @Environment(\.dismiss) private var dismiss
    
    // Gives us access to the shared ViewModel injected from higher up the view tree
    @Environment(TasksViewModel.self) private var viewModel

    // MARK: - State
    // These hold the temporary values as the user types them into the form
    @State private var name = ""
    @State private var assignedTo = ""
    @State private var dueDate = Date()
    
    // Controls whether the validation alert is currently visible
    @State private var showingAlert = false

    // MARK: - Body
    var body: some View {
        // We embed the Form in a NavigationStack so the sheet gets a title bar and toolbar buttons
        NavigationStack {
            Form {
                // Grouping the inputs into a visual section with a header
                Section(header: Text("Task Details")) {
                    // Two-way bindings update our @State variables automatically as the user types
                    TextField("Task Name", text: $name)
                    TextField("Assigned To", text: $assignedTo)
                    
                    // Displays a calendar picker. We restrict it to .date so they can't pick a time
                    DatePicker("Due Date", selection: $dueDate, displayedComponents: .date)
                }
            }
            .navigationTitle("New Task")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                // The "Cancel" button on the left side of the navigation bar
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss() // Closes the sheet without saving.
                    }
                }
                // The "Save" button on the right side of the navigation bar
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        saveTask() // Calls our custom function below
                    }
                }
            }
            // Displays an alert if validation fails.
            .alert("Validation Error", isPresented: $showingAlert) {
                Button("OK", role: .cancel) { } // Just dismisses the alert
            } message: {
                Text("Please enter both name and assignee")
            }
        }
    }

    // MARK: - Functions
    
    // Validates input, builds a TaskItem, saves it to the database, and dismisses the sheet
    private func saveTask() {
        // Guard against empty fields. If invalid, show the alert and exit the function early
        guard TaskItem.isValid(name: name, assignedTo: assignedTo) else {
            showingAlert = true
            return
        }
        
        let newTask = TaskItem(
            name: name,
            assignedTo: assignedTo,
            dueDate: dueDate,
            dateAdded: Date(), // Set to right now
            completed: false   // New tasks always start incomplete
        )
        
        // Send the task to the ViewModel, which passes it to the Repository and Firestore
        viewModel.add(newTask)
        
        // Close the sheet
        dismiss()
    }
}
