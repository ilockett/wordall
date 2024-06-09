//
//  LogoView.swift
//  WordAll
//
//  Created by Ian Lockett on 06/06/2024.
//

import SwiftUI

struct LogoView: View {

    private let font: Font

    private let animated: Bool

    init(font: Font = .titleLarge, animated: Bool = false) {
        self.font = font
        self.animated = animated
    }

    var body: some View {
        HStack(spacing: 2) {
            if animated {
                image
                    .symbolEffect(.variableColor.cumulative, options: .repeating)
            } else {
                image
            }
            Text("WordAll")
                .foregroundStyle(.waSecondary)
        }
        .font(font)
        .accessibilityElement(children: .combine)
        .accessibilityLabel("WordAll Logo")
        .accessibilityAddTraits(.isImage)
    }

    private var image: some View {
        Image(systemName: "chart.bar.doc.horizontal")
            .foregroundStyle(.waAccent)
    }
}

#Preview {
    VStack(spacing: 20) {
        LogoView()
        LogoView(font: .titleSmall)
        LogoView(animated: true)
    }
    .padding(50)
    .background(.waBackground)
}
