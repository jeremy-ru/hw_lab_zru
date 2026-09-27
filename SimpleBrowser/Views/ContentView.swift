//
//  ContentView.swift
//  SimpleBrowser
//
//  Created by Jeremy Ru on 2026/9/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ViewModel() // owner of the ViewModel
    
    var body: some View {
        // Top bar / web view / bottom bar, stacked vertically.
        VStack {
            SearchBar(viewModel: viewModel)
            WebView(viewModel: viewModel)
            BottomBar(viewModel: viewModel)
        }
        // Share sheet presented when the share button flips the flag.
        .sheet(isPresented: $viewModel.shouldShowShareSheet) {
            if let url = URL(string: "https://\(viewModel.urlString)") {
                ShareSheet(activityItems: [url])
            }
        }
    }
}
