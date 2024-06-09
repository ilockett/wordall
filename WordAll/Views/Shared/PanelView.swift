//
//  PanelView.swift
//  WordAll
//
//  Created by Ian Lockett on 06/06/2024.
//

import SwiftUI

enum PanelViewStyle {
    case primary
    case secondary
    case accent
}

struct PanelView<Content: View>: View {

    let content: () -> Content
    let style: PanelViewStyle

    init(style: PanelViewStyle = .accent,
         @ViewBuilder content: @escaping () -> Content) {
        self.style = style
        self.content = content
    }

    var body: some View {
        content()
            .frame(maxWidth: .infinity)
            .foregroundStyle(foregroundColor)
            .padding()
            .background(backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: 8))

    }

    private var backgroundColor: Color {
        switch style {
        case .primary:
            Color.waPrimary
        case .secondary:
            Color.waSecondary
        case .accent:
            Color.waAccent
        }
    }

    private var foregroundColor: Color {
        switch style {
        case .primary:
            Color.waBackground
        case .secondary:
            Color.waBackground
        case .accent:
            Color.waText
        }
    }
}

#Preview {
    PanelView {
        VStack(alignment: .leading, spacing: 10) {
            Text(verbatim: "Did you know?")
                .font(.bodyMediumBold)
            Text(verbatim: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.")
                .font(.bodySmallRegular)
        }
    }
    .padding()
}
