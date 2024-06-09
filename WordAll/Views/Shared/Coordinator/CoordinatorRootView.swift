//
//  CoordinatorRootView.swift
//  WordAll
//
//  Created by Ian Lockett on 05/06/2024.
//

import SwiftUI

struct CoordinatorRootView<RootContent: View, Destination: CoordinatorDestination, DestinationView: View>: View {

    private let destinationBuilder: (Destination, NavigationStyle) -> DestinationView
    private let rootContent: () -> RootContent
    private let navigationBarHidden: Bool

    init(coordinator: Coordinator<Destination>,
         navigationBarHidden: Bool = true,
         @ViewBuilder destinationBuilder: @escaping (Destination, NavigationStyle) -> DestinationView,
         @ViewBuilder rootContent: @escaping () -> RootContent) {
        self.coordinator = coordinator
        self.destinationBuilder = destinationBuilder
        self.rootContent = rootContent
        self.navigationBarHidden = navigationBarHidden
    }

    @State var coordinator: Coordinator<Destination>

    var body: some View {
        NavigationStack(path: $coordinator.navPath) {
            rootContent()
                .navigationDestination(for: Destination.self) { destination in
                    destinationBuilder(destination, .push)
                }
                .navigationBarHidden(navigationBarHidden)
        }
        .sheet(item: $coordinator.presentedSheet, onDismiss: coordinator.sheetDismissHandler) { destination in
            if let destination = destination.destination as? Destination {
                destinationBuilder(destination, .present)
            }
        }
        .fullScreenCover(item: $coordinator.presentedFullScreen, onDismiss: coordinator.fullScreenDismissHandler) { destination in
            if let destination = destination.destination as? Destination {
                destinationBuilder(destination, .present)
            }
        }
    }

}

enum NavigationStyle {
    case push
    case present
}
