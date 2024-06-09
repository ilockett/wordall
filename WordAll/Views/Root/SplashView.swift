//
//  SplashView.swift
//  WordAll
//
//  Created by Ian Lockett on 08/06/2024.
//

import SwiftUI

@MainActor
struct SplashView: View {

    @Environment(RootCoordinator.self) private var coordinator

    @State private var animate = false

    private let duration: CGFloat = 0.6

    var body: some View {
        GeometryReader { reader in
            ZStack {
                Color.waAccent

                Color.waSecondary
                    .offset(x: 0, y: backgroundOffsetY(reader))
                    .animation(.easeIn(duration: duration), value: animate)

                Color.waPrimary
                    .offset(x: 0, y: backgroundOffsetY(reader))
                    .animation(.easeIn(duration: duration).delay(duration), value: animate)

                Color.waBackground
                    .offset(x: 0, y: backgroundOffsetY(reader))
                    .animation(.easeIn(duration: duration).delay(duration * 2), value: animate)

                LogoView(font: logoFont, animated: true)
                    .offset(x: 0, y: backgroundOffsetY(reader))
                    .animation(.bouncy(duration: duration * 1.5, extraBounce: 0.15).delay(duration * 2.5), value: animate)

            }
            .onTapGesture {
                continueFromSplash()
            }
            .onAppear {
                withAnimation {
                    animate = true
                } completion: {
                    Task {
                        try? await Task.sleep(for: .seconds(2))
                        continueFromSplash()
                    }
                }
            }
        }
        .ignoresSafeArea()
    }

    private var logoFont: Font {
        if UIDevice.current.userInterfaceIdiom == .phone {
            .titleLarge
        } else {
            .title(fontSize: 80)
        }
    }

    private func backgroundOffsetY(_ reader: GeometryProxy) -> CGFloat {
        animate ? 0 : -(reader.size.height)
    }

    private func continueFromSplash() {
        guard coordinator.currentDestination != .home else { return }
        coordinator.navigate(to: .home)
    }

}

#Preview {
    SplashView()
        .environment(RootCoordinator())
}
