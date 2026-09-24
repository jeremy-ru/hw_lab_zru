//
//  ContentView.swift
//  SimpleBrowser
//
//  Created by Jeremy Ru on 2026/9/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        VStack {
            SearchBar(viewModel: viewModel)
            WebView(viewModel: viewModel)
            BottomBar(viewModel: viewModel)
        }
        .sheet(isPresented: $viewModel.shouldShowShareSheet) {
            if let url = URL(string: "https://\(viewModel.urlString)") {
                ShareSheet(activityItems: [url])
            }
        }
    }
}
