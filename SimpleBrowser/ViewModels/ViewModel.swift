//
//  ViewModel.swift
//  SimpleBrowser
//
//  Created by Jeremy Ru on 2026/9/23.
//

import Foundation
import Combine

// Actions the bottom-bar buttons can trigger
enum WebViewOptions {
    case back
    case forward
    case share
    case refresh
    case stop
}

class ViewModel: ObservableObject {
    @Published var urlString: String = "" // bound to SearchBar's TextField
    @Published var shouldShowShareSheet: Bool = false // controls share sheet presentation
    @Published var webViewOptionsPublisher = PassthroughSubject<WebViewOptions, Never>() // broadcasts button taps
    
    func goBack()    { webViewOptionsPublisher.send(.back) }
    func goForward() { webViewOptionsPublisher.send(.forward) }
    func share()     { webViewOptionsPublisher.send(.share) }
    func refresh()   { webViewOptionsPublisher.send(.refresh) }
    func stop()      { webViewOptionsPublisher.send(.stop) }
}
