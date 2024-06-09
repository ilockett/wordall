//
//  RandomWordView.swift
//  WordAll
//
//  Created by Ian Lockett on 05/06/2024.
//

import SwiftUI

@MainActor
struct RandomWordView: View {

    @Environment(RootCoordinator.self) private var coordinator

    @State private var viewModel = RandomWordViewModel()

    var body: some View {
        ZStack {
            Color.waBackground.ignoresSafeArea()
            VStack() {
                LogoView(animated: true)
                tiledWordPanel
                if !viewModel.shouldSelectNewWord {
                    moreInfoButton
                }
                refreshWordButton
                Spacer()
                aboutButton
            }
            .frame(maxWidth: 500, maxHeight: .infinity)
            .padding()
            .navigationBarBackButtonHidden()
            .task {
                if viewModel.shouldSelectNewWord {
                    await viewModel.selectRandomWord()
                }
            }
            .alert(isPresented: $viewModel.error.isNotNil()) {
                Alert(title: Text("Oh no!"),
                      message: Text(viewModel.error?.errorDescription ?? ""))
            }
        }

    }

    private var aboutButton: some View {
        Button(action: {
            coordinator.navigate(to: .about)
        }, label: {
            HStack {
                Text("About")
                LogoView(font: .bodyMediumBold)
            }
            .foregroundColor(.waText)
            .padding(.horizontal, 24)
            .padding(.vertical, 12)
            .background(Color.waAccent.opacity(0.2))
            .clipShape(RoundedRectangle(cornerRadius: 4))
            .accessibilityLabel("About Wordall")
        })
    }

    private func actionButton(style: PanelViewStyle,
                              systemImageName: String,
                              label: String,
                              displayChevron: Bool = true,
                              accessibilityIdentifier: String,
                              action: @escaping () -> Void) -> some View {
        Button(action: action, label: {
            PanelView(style: style) {
                HStack {
                    Image(systemName: systemImageName)
                        .symbolEffect(.pulse, options: .repeating, value: true)
                    Text(label)
                        .font(.bodyMediumBold)
                    if displayChevron {
                        Image(systemName: "chevron.right")
                    }
                }
            }
        })
        .accessibilityIdentifier(accessibilityIdentifier)
    }

    private var tiledWordPanel: some View {
        PanelView {
            VStack {
                Text("Your selected word is:")
                TiledWordView(word: $viewModel.selectedWord)
            }
            .accessibilityElement(children: .combine)
        }
    }

    private var moreInfoButton: some View {
        actionButton(style: .primary,
                     systemImageName: "info.square",
                     label: "More info about \"\(viewModel.selectedWord)\"",
                     accessibilityIdentifier: "randomword.button.moreinfo",
                     action: displayMoreInfo)
    }

    private var refreshWordButton: some View {
        actionButton(style: .accent,
                     systemImageName: "arrow.clockwise",
                     label: "Get a different word",
                     displayChevron: false,
                     accessibilityIdentifier: "randomword.button.refresh",
                     action: refreshWord)
        .padding(.top, 20)
    }

    private func displayMoreInfo() {
        coordinator.presentSheet(destination: .wordInfo(viewModel.selectedWord))
    }

    private func refreshWord() {
        Task {
            await viewModel.selectRandomWord()
        }
    }
}

#Preview {
    RandomWordView()
        .environment(RootCoordinator())
}
