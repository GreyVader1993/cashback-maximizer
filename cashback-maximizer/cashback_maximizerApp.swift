//
//  cashback_maximizerApp.swift
//  cashback-maximizer
//
//  Created by Tanmay Dureja on 11/8/25.
//

import SwiftUI

@main
struct cashback_maximizerApp: App {
    @StateObject private var viewModel = CardViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView() // 🔹 Use ContentView instead of CardCarouselView
        }
    }
}

