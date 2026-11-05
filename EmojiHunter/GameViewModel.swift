//
//  GameViewModel.swift
//  EmojiHunter
//
//  Created by Jeremy Ru on 2026/11/4.
//

import SwiftUI
import Observation
import Combine

@Observable
class GameViewModel {
    
    // MARK: - Properties setup
    // The time allowed per round (10 seconds). 'static' means it's shared across all instances
    static let roundDuration = 10
    
    var currentLevel = 0
    var showNext = false
    
    // Set up timer for the game
    // We only want the 'timeRemaining' integer to trigger updates.
    @ObservationIgnored var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    var timeRemaining = roundDuration
    
    // Set initial emoji status to searching
    var emojiStatus = EmojiSearch.searching
    
    // MARK: - Timing methods
    // Called every second by the SwiftUI view listening to the timer
    func adjustTime() {
        if emojiStatus == .searching {
            if timeRemaining > 0 {
                timeRemaining -= 1 // Tick down the clock
            } else {
                // Time ran out! Change state and stop the timer
                emojiStatus = .notFound
                showNext = true
                timer.upstream.connect().cancel()
            }
        } else if emojiStatus == .found {
            // The camera found the object. Reset the timer and stop it
            timeRemaining = Self.roundDuration
            timer.upstream.connect().cancel()
        }
    }
    
    func instantiateTimer() {
        // Re-creates and restarts the timer
        self.timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    }
    
    // MARK: - Gameplay methods
    // Called when the user taps "NEXT"
    func startSearch() {
        // If we are at the very last emoji in the array, the game is over
        if self.currentLevel == emojiObjects.count - 1 {
            self.emojiStatus = .gameOver
        } else {
            // Otherwise, advance to the next level and start a new round
            self.currentLevel = self.currentLevel + 1
            startRound()
        }
    }
    
    // Called when the user taps "GAME OVER" to play again
    func restartGame() {
        self.currentLevel = 0
        startRound()
    }
    
    // Resets all variables needed for a fresh 10-second round
    func startRound() {
        self.timeRemaining = Self.roundDuration
        self.emojiStatus = .searching
        self.showNext = false
        self.instantiateTimer()
    }
    
    // Returns the correct styled Text view based on the current game state
    func emojiResultText() -> Text {
        switch emojiStatus {
        case .found:
            return Text("\(emojiObjects[currentLevel].emoji) is FOUND")
                .font(.system(size: 50, design: .rounded))
                .fontWeight(.bold)
        case .notFound:
            return Text("\(emojiObjects[currentLevel].emoji) NOT FOUND")
                .font(.system(size: 50, design: .rounded))
                .foregroundColor(.red)
                .fontWeight(.bold)
        default:
            // While searching, just show the emoji to hunt for
            return Text(emojiObjects[currentLevel].emoji)
                .font(.system(size: 50, design: .rounded))
                .fontWeight(.bold)
        }
    }
}
