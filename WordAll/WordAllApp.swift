//
//  WordAllApp.swift
//  WordAll
//
//  Created by Ian Lockett on 06/06/2024.
//

import SwiftUI

@main
struct WordAllApp: App {

    var body: some Scene {
        WindowGroup {
            RootView()
                .environment(\.font, .bodyMediumBold)
                .foregroundColor(.waText)
                .tint(.waPrimary)
        }
    }
}
