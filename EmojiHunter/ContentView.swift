//
//  ContentView.swift
//  EmojiHunter
//
//  Created by Jeremy Ru on 2026/11/4.
//

import SwiftUI

struct ContentView: View {
    
    // Using @State (instead of @StateObject) because GameViewModel uses the @Observable macro
    @State private var viewModel = GameViewModel()
    
    var body: some View {
        // ZStack layers the camera/background underneath the UI text and buttons
        ZStack {
            // If the user missed the object or successfully found it, show the black screen with "NEXT"
            if viewModel.showNext || (viewModel.emojiStatus == .found && viewModel.emojiStatus != .gameOver) {
                Color.black.ignoresSafeArea()
                
                Button(action: {
                    viewModel.startSearch()
                }) {
                    Text("NEXT")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.green)
                        .cornerRadius(10)
                }
            } else {
                // Otherwise, show the live camera feed.
                CustomCameraRepresentable(
                    emojiString: emojiObjects[viewModel.currentLevel].emojiName,
                    emojiFound: $viewModel.emojiStatus
                )
                .ignoresSafeArea()
            }

            VStack {
                Spacer() // Pushes everything below to the bottom of the screen
                
                if viewModel.emojiStatus == .gameOver {
                    // Game Over screen with a restart button
                    Button(action: {
                        viewModel.restartGame()
                    }) {
                        Text("GAME OVER\nTap to restart")
                            .font(.title)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.red)
                            .cornerRadius(10)
                    }
                    .padding(.bottom, 50)
                } else if viewModel.emojiStatus == .searching {
                    // Live timer display
                    Text("\(viewModel.timeRemaining)")
                        .font(.system(size: 80, weight: .bold, design: .rounded))
                        .foregroundColor(.yellow)
                        .shadow(radius: 10)
                        // Listens to the Combine timer published by the ViewModel and updates the time
                        .onReceive(viewModel.timer) { _ in
                            viewModel.adjustTime()
                        }
                }
                
                // Displays the target emoji or the FOUND/NOT FOUND result
                viewModel.emojiResultText()
                    .padding(.bottom, 50)
            }
        }
        // Start the first round when the app opens
        .onAppear {
            // Start the first round only if it hasn't started yet
            if viewModel.emojiStatus == .searching && viewModel.timeRemaining == GameViewModel.roundDuration {
                viewModel.startRound()
            }
        }
    }
}

#Preview {
    ContentView()
}
