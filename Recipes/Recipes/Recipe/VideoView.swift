//
//  VideoView.swift
//  Recipes
//
//  Created by Matt Zawodniak on 4/10/25.
//

import SwiftUI
import WebKit

// "https://www.youtube.com/watch?v=rp8Slv4INLk"
struct VideoView: UIViewRepresentable {
  let videoURLString: String

  func makeUIView(context: Context) -> WKWebView {
    return WKWebView()
  }

  func updateUIView(_ uiView: WKWebView, context: Context) {
    let youtubeEmbedURLString =
    "https://www.youtube.com/embed/\(videoURLString.split(separator: "=").last!)"
    guard let youtubeURL = URL(string: youtubeEmbedURLString) else { return }
    uiView.scrollView.isScrollEnabled = false
    uiView.load(URLRequest(url: youtubeURL))
  }
}
