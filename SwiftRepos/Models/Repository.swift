//
//  Repository.swift
//  SwiftRepos
//
//  Created by Jeremy Ru on 2026/10/1.
//

import Foundation

// `Identifiable` lets List track rows via `id`
// `Sendable` is required by Alamofire's responseDecodable
nonisolated struct Repository: Codable, Identifiable, Hashable, Sendable {
    let id: Int
    let name: String
    let itemDescription: String?
    let htmlURL: String
    let stargazersCount: Int

    // Maps snake_case JSON keys to camelCase Swift properties
    // `description` is renamed to avoid clashing with CustomStringConvertible
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case itemDescription = "description"
        case htmlURL = "html_url"
        case stargazersCount = "stargazers_count"
    }
}
