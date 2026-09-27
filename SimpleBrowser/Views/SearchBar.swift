//
//  SearchBar.swift
//  SimpleBrowser
//
//  Created by Jeremy Ru on 2026/9/23.
//

import SwiftUI

struct SearchBar: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        // Label + text field; field writes directly into viewModel.urlString.
        HStack {
            Text("URL:")
            TextField("URL", text: $viewModel.urlString)
                .keyboardType(.URL) // URL-optimized keyboard
                .autocapitalization(.none) // ensure no automated capitalization
                .disableAutocorrection(true) // disable automatically "correct" URLs
        }
    }
}
