//
//  Repositories.swift
//  SwiftRepos
//
//  Created by Jeremy Ru on 2026/10/2.
//

import Foundation

// `nonisolated` lets Alamofire decode this off the main actor
nonisolated struct Repositories: Codable {
    let items: [Repository]
}
