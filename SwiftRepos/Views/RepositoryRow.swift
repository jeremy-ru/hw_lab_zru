//
//  RepositoryRow.swift
//  SwiftRepos
//
//  Created by Jeremy Ru on 2026/10/1.
//

import SwiftUI

struct RepositoryRow: View {
    // Plain value type — no @Observable needed since Repository is a struct
    let repo: Repository

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(repo.name)
                .font(.headline)

            if let description = repo.itemDescription {
                Text(description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
            }

            HStack(spacing: 4) {
                Image(systemName: "star.fill")
                    .font(.caption)
                    .foregroundColor(.yellow)
                // .formatted() adds thousands separators (45000 → 45,000)
                Text("\(repo.stargazersCount.formatted())")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .padding(.vertical, 4)
        }
    }
}
