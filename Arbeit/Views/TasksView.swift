//
//  TasksView.swift
//  Arbeit
//
//  Created by Jeremy Ru on 2026/10/22.
//

import SwiftUI

struct TasksView: View {
    @Environment(TasksViewModel.self) private var viewModel
    @State private var showingNewTask = false

    var body: some View {
        List {
            ForEach(viewModel.tasks) { task in
                NavigationLink(value: task) {
                    TaskRowView(task: task)
                }
            }
            .onDelete(perform: deleteTask)
        }
        .navigationTitle("Arbeit")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: { showingNewTask = true }) {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $showingNewTask) {
            NewTaskView()
                .environment(viewModel)
        }
        .navigationDestination(for: TaskItem.self) { task in
            TaskDetailsView(task: task)
        }
    }

    // Deletes tasks at the swipe-to-delete indices
    private func deleteTask(at offsets: IndexSet) {
        for index in offsets {
            viewModel.destroy(viewModel.tasks[index])
        }
    }
}
