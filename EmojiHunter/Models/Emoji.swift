//
//  Emoji.swift
//  EmojiHunter
//
//  Created by Jeremy Ru on 2026/11/4.
//

import Foundation

// Delegate protocol to pass the AI's detection result from the camera back to the ViewModel
protocol EmojiFoundDelegate: AnyObject {
    func emojiWasFound(result: Bool)
}

// Defines the current state of the game/round
enum EmojiSearch {
    case found
    case notFound
    case searching
    case gameOver
}

// Represents a single target object to hunt for
struct EmojiModel: Identifiable {
    let id = UUID()
    var emoji: String
    var emojiName: String
}

// The list of targets for the game
let emojiObjects: [EmojiModel] = [
    EmojiModel(emoji: "💻", emojiName: "laptop"),
    EmojiModel(emoji: "🖊️", emojiName: "pen"),
    EmojiModel(emoji: "📖", emojiName: "book"),
    EmojiModel(emoji: "☕️", emojiName: "cup"),
    EmojiModel(emoji: "📱", emojiName: "phone")
]
