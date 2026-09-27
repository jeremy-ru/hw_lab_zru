//
//  BottomBar.swift
//  SimpleBrowser
//
//  Created by Jeremy Ru on 2026/9/23.
//

import SwiftUI

struct BottomBar: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        HStack {
            // Make sure five buttons spread evenly with Spacers.
            Button(action: viewModel.goBack) {
                Image(systemName: "chevron.left")
            }
            Spacer()
            
            Button(action: viewModel.goForward) {
                Image(systemName: "chevron.right")
            }
            Spacer()
            
            Button(action: viewModel.share) {
                Image(systemName: "square.and.arrow.up")
            }
            Spacer()
            
            Button(action: viewModel.refresh) {
                Image(systemName: "arrow.clockwise")
            }
            Spacer()
            
            Button(action: viewModel.stop) {
                Image(systemName: "xmark")
            }
        }
        .padding()
    }
}
