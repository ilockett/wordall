//
//  WordDefinitionViewModel.swift
//  WordAll
//
//  Created by Ian Lockett on 08/06/2024.
//

import Foundation
import SwiftUI

@Observable class WordDefinitionViewModel {

    var word: String

    var isLoading = false
    var error: WordRepositoryError?
    var definitions: [Definition]?

    private let repository: WordRepository

    init(word: String, repository: WordRepository = WordAllRepository()) {
        self.word = word
#if DEBUG
        if ProcessInfo.processInfo.arguments.contains("UITEST") {
            self.repository = UITestWordRepository()
        } else {
            self.repository = repository
        }
#else
        self.repository = repository
#endif
    }

    func fetchDefinition() async {
        isLoading = true
        defer { isLoading = false }
        do {
            self.definitions = try await repository.definitions(for: word)
        } catch let error as WordRepositoryError {
            self.error = error
        } catch {
            self.error = .unexpectedError(message: error.localizedDescription)
        }
    }

}
