//
//  ContentView.swift
//  SwiftRepos
//
//  Created by Jeremy Ru on 2026/10/1.
//

import SwiftUI

struct ContentView: View {
    // Replaces @StateObject from the old ObservableObject pattern
    @State private var viewModel = RepositoryViewModel()

    var body: some View {
        NavigationStack {
            List(viewModel.filteredRepos) { repo in
                // value-based NavigationLink + navigationDestination
                // replaces the old NavigationLink(destination:) pattern
                NavigationLink(value: repo) {
                    RepositoryRow(repo: repo)
                }
            }
            .navigationTitle("Swift Repos")
            // Bindable(...) gives searchable a two-way binding to the
            // @Observable view model's searchText
            .searchable(text: Bindable(viewModel).searchText, prompt: "Search repos")
            .navigationDestination(for: Repository.self) { repo in
                if let url = URL(string: repo.htmlURL) {
                    WebView(url: url)
                        .navigationTitle(repo.name)
                        .navigationBarTitleDisplayMode(.inline)
                }
            }
            .onAppear {
                // Only fetch once — avoids re-hitting the API when the user swipes back from a WebView
                if viewModel.repos.isEmpty {
                    viewModel.loadRepositories()
                }
            }
        }
    }
}
