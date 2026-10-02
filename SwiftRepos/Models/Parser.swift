//
//  Parser.swift
//  SwiftRepos
//
//  Created by Jeremy Ru on 2026/10/1.
//

import Foundation
import Alamofire

// Handles the network call to GitHub's search API
class Parser {
    // GitHub search endpoint: most-starred Swift repos, descending
    private let url = "https://api.github.com/search/repositories?q=language:swift&sort=stars&order=desc"

    // Fetches repositories and returns them via the completion handler
    // Calls back with an empty array on failure
    func fetchRepositories(completion: @escaping ([Repository]) -> Void) {
        AF.request(url)
            .validate() // Treat non-2xx as failure
            .responseDecodable(of: Repositories.self) { response in
                switch response.result {
                case .success(let container):
                    completion(container.items) // Unwrap the `items` array
                case .failure(let error):
                    print("Error fetching repositories: \(error.localizedDescription)")
                    completion([])
                }
            }
    }
}
