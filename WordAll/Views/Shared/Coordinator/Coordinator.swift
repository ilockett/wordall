//
//  Coordinator.swift
//  WordAll
//
//  Created by Ian Lockett on 05/06/2024.
//

// Inspired by https://levelup.gitconnected.com/modular-navigation-in-swiftui-a-comprehensive-guide-5eeb8a511583

import SwiftUI

@MainActor
@Observable
open class Coordinator<Destination: CoordinatorDestination> {
    
    var navPath = [Destination]()
    var presentedSheet: IdentifiableDestination?
    var presentedFullScreen: IdentifiableDestination?

    private(set) var sheetDismissHandler: (() -> Void)?
    private(set) var fullScreenDismissHandler: (() -> Void)?

    var dismissHandler: DismissAction?

    var currentDestination: Destination? {
        navPath.last
    }

    func presentSheet(destination: Destination, onDismiss: (() -> Void)? = nil) {
        sheetDismissHandler = onDismiss
        presentedSheet = IdentifiableDestination(destination: destination)
    }

    func presentFullScreen(destination: Destination, onDismiss: (() -> Void)? = nil) {
        fullScreenDismissHandler = onDismiss
        presentedFullScreen = IdentifiableDestination(destination: destination)
    }

    func navigate(to destination: Destination) {
        navPath.append(destination)
    }

    func navigate(to destinations: [Destination]) {
        var currentPath = navPath
        destinations.forEach {
            currentPath.append($0)
        }
        navPath = currentPath
    }

    func navigateBack() {
        guard !navPath.isEmpty else {
            return
        }
        navPath.removeLast()
    }

    func navigateBack(to destination: Destination) {
        while currentDestination != destination && !navPath.isEmpty {
            navigateBack()
        }
    }

    func navigateToRoot() {
        navPath.removeLast(navPath.count)
    }

    func dismissSheet() {
        presentedSheet = nil
    }

    func dismissFullScreen() {
        presentedFullScreen = nil
    }

    func dismiss() {
        dismissHandler?()
    }
}

public protocol CoordinatorDestination: Hashable, Identifiable {}

public class IdentifiableDestination: Identifiable {
    public let destination: any Identifiable

    public init(destination: any Identifiable) {
        self.destination = destination
    }
}
