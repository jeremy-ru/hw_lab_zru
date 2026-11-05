//
//  Coordinator.swift
//  EmojiHunter
//
//  Created by Jeremy Ru on 2026/11/4.
//

import Foundation
import SwiftUI

class Coordinator: NSObject, EmojiFoundDelegate {
    // A Binding allows us to update the ViewModel's state directly from this UIKit context
    var emojiFound: Binding<EmojiSearch>
    
    init(emojiFound: Binding<EmojiSearch>) {
        self.emojiFound = emojiFound
    }
    
    // This is called by the CameraViewController when the AI successfully spots the target
    func emojiWasFound(result: Bool) {
        if result {
            // wrappedValue allows us to mutate the underlying data the Binding points to
            self.emojiFound.wrappedValue = .found
        }
    }
}
