//
//  ShareSheet.swift
//  SimpleBrowser
//
//  Created by Jeremy Ru on 2026/9/24.
//

import SwiftUI
import UIKit

// Wraps UIActivityViewController so SwiftUI can present it via .sheet
struct ShareSheet: UIViewControllerRepresentable {
    typealias Callback = (_ activityType: UIActivity.ActivityType?,
                          _ completed: Bool,
                          _ returnedItems: [Any]?,
                          _ error: Error?) -> Void
    
    let activityItems: [Any] // items to share
    let applicationActivities: [UIActivity]? = nil // custom activities
    let excludedActivityTypes: [UIActivity.ActivityType]? = nil
    let callback: Callback? = nil
    
    // Builds the UIActivityViewController with the items to share,
    // optional custom activities, excluded types, and completion handler.
    func makeUIViewController(context: Context) -> UIViewController {
        let controller = UIActivityViewController(
            activityItems: activityItems,
            applicationActivities: applicationActivities)
        controller.excludedActivityTypes = excludedActivityTypes
        controller.completionWithItemsHandler = callback
        return controller
    }
    
    // Nothing to update in place — sheet is fresh each presentation.
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}
