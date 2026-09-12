//
//  DefinitionView.swift
//  RailsCards
//
//  Created by Jeremy Ru on 2026/9/10.
//

import SwiftUI

struct DefinitionView: View {
    let viewModel: CardViewModel

    var body: some View {
        Text(viewModel.flashcard.definition)
            .multilineTextAlignment(.center)
            .padding()
            .frame(width: 350, height: 200)
            .overlay(
                RoundedRectangle(cornerRadius: 10.0).stroke(Color.gray)
            )
    }
}

#Preview {
    DefinitionView(viewModel: CardViewModel())
}
