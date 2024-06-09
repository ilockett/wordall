//
//  MockWordRepository.swift
//  WordAllTests
//
//  Created by Ian Lockett on 08/06/2024.
//

import Foundation
@testable import WordAll

class MockWordRepository: WordRepository {

    private var wordToReturn = "hello"
    private var errorToThrow: Error?
    private var definitionsToReturn: [Definition]?

    required init(resourcePath: String? = nil, service: WordService = MockWordService()) {
    }

    convenience init(errorToThrow: Error) {
        self.init()
        self.errorToThrow = errorToThrow
    }

    convenience init(wordToReturn: String) {
        self.init()
        self.wordToReturn = wordToReturn
    }

    convenience init(definitionsToReturn: [Definition]) {
        self.init()
        self.definitionsToReturn = definitionsToReturn
    }

    func randomWord() async throws -> String {
        if let errorToThrow {
            throw errorToThrow
        }
        return wordToReturn
    }

    func definitions(for word: String) async throws -> [Definition]? {
        if let errorToThrow {
            throw errorToThrow
        }
        return definitionsToReturn!
    }

}
