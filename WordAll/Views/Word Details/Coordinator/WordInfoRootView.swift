//
//  WordInfoRootView.swift
//  WordAll
//
//  Created by Ian Lockett on 08/06/2024.
//

import Foundation
import SwiftUI

@MainActor
struct WordInfoRootView: View {

    @Environment(\.dismiss) private var dismiss

    @State private var coordinator = WordInfoCoordinator()

    let word: String

    var body: some View {
        CoordinatorRootView(coordinator: coordinator, navigationBarHidden: false, destinationBuilder: destinationBuilder) {
            WordDefinitionView(word: word)
        }
        .environment(coordinator)
        .onAppear {
            coordinator.dismissHandler = dismiss
        }
    }

    @ViewBuilder
    private func destinationBuilder(_ destination: WordInfoDestination, _ navigationStyle: NavigationStyle) -> some View {
        switch destination {
        case .rhymingWords, .examples:
            // TODO: Implement additional views!
            EmptyView()
        }
    }
}
