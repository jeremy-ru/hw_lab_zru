//
//  WebView.swift
//  SwiftRepos
//
//  Created by Jeremy Ru on 2026/10/1.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    // The page to load
    let url: URL

    // Called once, when SwiftUI first needs the underlying UIKit view
    func makeUIView(context: Context) -> WKWebView {
        WKWebView()
    }

    // Called whenever SwiftUI state changes — here, when `url` changes
    func updateUIView(_ webView: WKWebView, context: Context) {
        webView.load(URLRequest(url: url))
    }
}
