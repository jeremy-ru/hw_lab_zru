//
//  CardViewModel.swift
//  RailsCards
//
//  Created by Jeremy Ru on 2026/9/10.
//

import Foundation
import Observation

@Observable
class CardViewModel {
    let deck = Deck()
    var flashcard: Flashcard

    init() {
        self.flashcard = deck.drawRandomCard()
    }

    func drawNewCard() {
        self.flashcard = deck.drawRandomCard()
    }
}
