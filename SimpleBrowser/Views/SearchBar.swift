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
        HStack {
            Text("URL:")
            TextField("URL", text: $viewModel.urlString)
                .keyboardType(.URL)
                .autocapitalization(.none)
                .disableAutocorrection(true)
        }
    }
}
