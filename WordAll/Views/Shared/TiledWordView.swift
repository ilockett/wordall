//
//  TiledWordView.swift
//  WordAll
//
//  Created by Ian Lockett on 08/06/2024.
//

import SwiftUI

struct TiledWordView: View {

    @Binding var word: String

    @State private var scaleY = 1.0

    private let animationDuration = 0.25

    @State var wordToDisplay: String = ""


    var body: some View {
        HStack {
            ForEach(Array(wordToDisplay.enumerated()), id: \.offset) { character in
                TiledLetterView(letter: character.element)
            }
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel(word)
        .accessibilityIdentifier("tiled-word-view")
        .scaleEffect(x: 1, y: scaleY)
        .onChange(of: word) {
            withAnimation(.easeInOut(duration: animationDuration)) {
                scaleY = 0
            } completion: {
                wordToDisplay = word
            }
            withAnimation(.easeInOut(duration: animationDuration).delay(animationDuration)) {
                scaleY = 1
            }
        }
        .onAppear {
            wordToDisplay = word
        }
    }

}

struct TiledLetterView: View {

    let letter: Character

    private let cornerRadius: CGFloat = 4
    private let minDimension: CGFloat = 40

    var body: some View {
        Text(letter.uppercased())
            .foregroundStyle(.waBackground)
            .font(.titleMedium)
            .padding(4)
            .frame(minWidth: minDimension)
            .frame(minHeight: minDimension)
            .background(.waSecondary)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(.waBackground, lineWidth: 1)
            )
            .padding(1)
    }

}

#Preview {
    @State var word = "hello"

    return PanelView {
        TiledWordView(word: $word)
    }
    .padding()
}
