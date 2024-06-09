//
//  RandomWordViewModel.swift
//  WordAll
//
//  Created by Ian Lockett on 08/06/2024.
//

import Foundation
import SwiftUI

@Observable class RandomWordViewModel {

    var selectedWord = defaultWord
    var error: WordRepositoryError?

    var shouldSelectNewWord: Bool {
        selectedWord == Self.defaultWord
    }

    private let repository: WordRepository

    private static let defaultWord = "-----"

    init(repository: WordRepository = WordAllRepository()) {
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

    func selectRandomWord() async {
        do {
            selectedWord = try await repository.randomWord()
        } catch let error as WordRepositoryError {
            self.error = error
        } catch {
            self.error = .unexpectedError(message: error.localizedDescription)
        }
    }

}
