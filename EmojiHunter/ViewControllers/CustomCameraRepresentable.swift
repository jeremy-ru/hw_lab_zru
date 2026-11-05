//
//  CustomCameraRepresentable.swift
//  EmojiHunter
//
//  Created by Jeremy Ru on 2026/11/4.
//

import Foundation
import SwiftUI

struct CustomCameraRepresentable: UIViewControllerRepresentable {
    // The target string passed down to the camera
    var emojiString: String
    // A two-way binding to the game state: the camera will update this when it finds the object
    @Binding var emojiFound: EmojiSearch
    
    // Creates the actual UIKit View Controller
    func makeUIViewController(context: Context) -> CameraViewController {
        let controller = CameraViewController(emoji: emojiString)
        // Assign the Coordinator to handle callbacks from the camera
        controller.delegate = context.coordinator
        return controller
    }
    
    // Required by the protocol, but we don't need to update the camera VC in this case
    func updateUIViewController(_ cameraViewController: CameraViewController, context: Context) {}
    
    // Creates the Coordinator that bridges the UIKit delegate callbacks to the SwiftUI Binding
    func makeCoordinator() -> Coordinator {
        Coordinator(emojiFound: $emojiFound)
    }
}
