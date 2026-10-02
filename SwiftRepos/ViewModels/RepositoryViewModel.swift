//
//  RepositoryViewModel.swift
//  SwiftRepos
//
//  Created by Jeremy Ru on 2026/10/1.
//

import Foundation
import Observation

// `@Observable` replaces ObservableObject/@Published. SwiftUI tracks only the properties each view actually reads
@Observable
class RepositoryViewModel {
    
    // MARK: - State
    var repos: [Repository] = []
    var searchText: String = ""

    // Derived state: computed on the fly so it can never desync from repos
    var filteredRepos: [Repository] {
        guard !searchText.isEmpty else { return repos }
        return repos.filter { repo in
            repo.name.localizedCaseInsensitiveContains(searchText)
        }
    }

    // Parser: an implementation detail
    @ObservationIgnored private let parser = Parser()
    
    // MARK: - Loading
    
    // Fetches repos from GitHub. `[weak self]` avoids a retain cycle if the user navigates away mid-request
    func loadRepositories() {
        parser.fetchRepositories { [weak self] repos in
            self?.repos = repos
        }
    }
}
