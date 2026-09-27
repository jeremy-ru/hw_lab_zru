//
//  WebView.swift
//  SimpleBrowser
//
//  Created by Jeremy Ru on 2026/9/24.
//

import SwiftUI
import WebKit
import Combine

// Bridges UIKit's WKWebView into SwiftUI.
struct WebView: UIViewRepresentable {
    @ObservedObject var viewModel: ViewModel
    
    // Create the WKWebView once and assign the Coordinator as delegate
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        return webView
    }
    
    // Triggers when urlString changes; prepend https:// and load
    func updateUIView(_ webView: WKWebView, context: Context) {
        if let url = URL(string: "https://\(viewModel.urlString)") {
            webView.load(URLRequest(url: url))
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(webView: self)
    }
    
    // Delegate + Combine subscriber for button taps
    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: WebView
        var webViewOptionsSubscriber: AnyCancellable?
        
        init(webView: WebView) {
            self.parent = webView
        }
        
        deinit {
            webViewOptionsSubscriber?.cancel()
        }
        
        // On each new page load, subscribe to the ViewModel's publisher
        func webView(_ webView: WKWebView,
                     didStartProvisionalNavigation navigation: WKNavigation!) {
            webViewOptionsSubscriber = parent.viewModel.webViewOptionsPublisher
                .sink { webViewOption in
                    switch webViewOption {
                    case .back:
                        if webView.canGoBack { webView.goBack() }
                    case .forward:
                        if webView.canGoForward { webView.goForward() }
                    case .share:
                        self.parent.viewModel.shouldShowShareSheet = true
                    case .refresh:
                        webView.reload()
                    case .stop:
                        webView.stopLoading()
                    }
                }
        }
    }
}
