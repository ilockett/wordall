//
//  WordDefinitionView.swift
//  WordAll
//
//  Created by Ian Lockett on 08/06/2024.
//

import SwiftUI

struct WordDefinitionView: View {

    @Environment(WordInfoCoordinator.self) private var coordinator

    @State private var viewModel: WordDefinitionViewModel

    @State private var contentSize: CGSize = .zero

    init(word: String) {
        viewModel = .init(word: word)
    }

    var body: some View {
        VStack(spacing: 20) {
            TiledWordView(word: $viewModel.word)
            if let definitions = viewModel.definitions, !definitions.isEmpty {
                detailsView(definitions: definitions)
            } else if viewModel.isLoading {
                detailsView(definitions: [placeholderDefinition])
                    .redacted(reason: .placeholder)
                    .animation(.default, value: viewModel.isLoading)
            } else {
                noDefinitionsView
            }
        }
        .frame(maxWidth: .infinity)
        .background(.waAccent)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: coordinator.dismiss) {
                    Text("Close")
                }
            }
        }
        .alert(isPresented: $viewModel.error.isNotNil()) {
            Alert(title: Text("Oh no!"),
                  message: Text(viewModel.error?.errorDescription ?? ""))
        }
        .task {
            await viewModel.fetchDefinition()
        }
    }

    // MARK: Private Components

    private var noDefinitionsView: some View {
        ContentUnavailableView("Sorry!",
                               systemImage: "chart.bar.doc.horizontal",
                               description: Text("No definitions were found for \"\(viewModel.word)\""))
            .background(.waSecondary)
            .foregroundColor(.waBackground)
    }

    private func detailsView(definitions: [Definition]) -> some View {
        Group {
            Text("\(definitions.count) definitions:")
                .font(.bodyLargeBold)
            TabView {
                ForEach(definitions, id: \.definition) { definition in
                    definitionCard(definition)
                }
            }
            .frame(maxWidth: .infinity)
            .tabViewStyle(PageTabViewStyle())
            .background(.waSecondary)
        }
    }

    private func definitionCard(_ definition: Definition) -> some View {
        VStack {
            VStack(alignment: .leading, spacing: 20) {
                Text(definition.partOfSpeech)
                    .font(.bodyMediumBold)
                Text(definition.definition)
                    .font(.bodyLargeBold)
                    .accessibilityIdentifier("worddefinition.text.definition")
                if let synonyms = definition.synonyms {
                    synonymsList(synonyms)
                }
            }
            .padding()
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .topLeading)
            .background(.waBackground)
            .foregroundColor(.waText)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .padding(20)
            Spacer()
        }
        .padding(.top, 30)
    }

    private func synonymsList(_ synonyms: [String]) -> some View {
        VStack(alignment: .leading, spacing: 3) {
            Text("Synonyms:")
                .font(.bodyMediumBold)
            ForEach(synonyms.prefix(8), id: \.self) { synonym in
                HStack {
                    Text("\u{2022}")
                        .accessibilityHidden(true)
                    Text(synonym.capitalized)
                }
                .font(.bodyMediumRegular)
            }

        }
    }

    private let placeholderDefinition = Definition (definition: "Lorum ipsum dolor sit amet",
                                              partOfSpeech: "noun",
                                              synonyms: ["Lorum", "Ipsum"],
                                              typeOf: nil,
                                              derivation: nil)
}

#Preview {
    NavigationView {
        WordDefinitionView(word: "young")
            .environment(WordInfoCoordinator())
    }
}
