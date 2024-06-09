//
//  WordRepository.swift
//  WordAll
//
//  Created by Ian Lockett on 08/06/2024.
//

import Foundation

protocol WordRepository {
    init(resourcePath: String?, service: WordService)

    func randomWord() async throws -> String
    func definitions(for word: String) async throws -> [Definition]?
}

class WordAllRepository: WordRepository {

    private let resourcePath: String?
    private let service: WordService

    required init(resourcePath: String? = Bundle.main.path(forResource: "words", ofType: "txt"),
                  service: WordService = WordAllService()) {
        self.resourcePath = resourcePath
        self.service = service
    }

    func randomWord() async throws -> String {
        guard let randomWord = try await allWords.randomElement(), !randomWord.isEmpty else {
            throw WordRepositoryError.randomWordNotFound
        }
        return String(randomWord)
    }

    func definitions(for word: String) async throws -> [Definition]? {
        do {
            return try await service.fetchDetails(word: word).definitions
        } catch let error as NetworkError {
            throw WordRepositoryError.networkError(error)
        } catch {
            throw WordRepositoryError.unexpectedError(message: error.localizedDescription)
        }
    }

    // MARK: Private Methods

    private var allWords: [String.SubSequence] {
        get async throws {
            guard let resourcePath else {
                throw WordRepositoryError.wordsFileNotFound
            }
            do {
                let wordsString = try String(contentsOfFile: resourcePath)
                return wordsString.split(maxSplits: Int.max,
                                         omittingEmptySubsequences: true,
                                         whereSeparator: \.isNewline)
            } catch {
                throw WordRepositoryError.wordsFileNotFound
            }
        }
    }

}
