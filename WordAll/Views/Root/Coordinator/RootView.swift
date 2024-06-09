//
//  RootView.swift
//  WordAll
//
//  Created by Ian Lockett on 08/06/2024.
//

import Foundation
import SwiftUI

@MainActor
struct RootView: View {

    @State private var coordinator = RootCoordinator()

    var body: some View {
        CoordinatorRootView(coordinator: coordinator, destinationBuilder: destinationBuilder) {
            SplashView()
        }
        .environment(coordinator)
    }

    @ViewBuilder
    private func destinationBuilder(_ destination: RootDestination, _ navigationStyle: NavigationStyle) -> some View {
        switch destination {
        case .home:
            RandomWordView()
        case .about:
            AboutView()
        case .wordInfo(let word):
            WordInfoRootView(word: word)
        }
    }
}
