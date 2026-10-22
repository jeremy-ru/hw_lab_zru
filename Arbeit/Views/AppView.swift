//
//  AppView.swift
//  Arbeit
//
//  Created by Jeremy Ru on 2026/10/22.
//

import SwiftUI

struct AppView: View {
    // @State ensures it persists and isn't recreated when the view updates
    @State private var tasksViewModel = TasksViewModel()

    var body: some View {
        // TabView creates the bottom tab bar.
        TabView {
            
            // TAB 1: The Task List
            // We wrap it in a NavigationStack so we can push to the Details view
            NavigationStack {
                TasksView()
            }
            .tabItem {
                Image(systemName: "checkbox.rectangle.stack.fill")
                Text("Tasks")
            }

            // TAB 2: The New Task Form
            // Also wrapped in a NavigationStack so it gets a title bar
            NavigationStack {
                NewTaskView()
            }
            .tabItem {
                Image(systemName: "plus.app.fill")
                Text("New Task")
            }
        }
        // This injects the ViewModel into the environment
        .environment(tasksViewModel)
    }
}
