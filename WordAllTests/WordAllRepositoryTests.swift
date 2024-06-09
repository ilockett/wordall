//
//  WordRepositoryTests.swift
//  WordAllTests
//
//  Created by Ian Lockett on 08/06/2024.
//

import XCTest
@testable import WordAll

final class WordAllRepositoryTests: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test_randomWord_succeeds() async {
        let sut = WordAllRepository(resourcePath: pathForTextFile(named: "testword"))
        do {
            let word = try await sut.randomWord()
            XCTAssertEqual(word, "hello")
        } catch {
            XCTFail("Unexpected failure fetching random word")
        }
    }

    func test_randomWord_throwsErrorWithInvalidResourcePath() async {
        let sut = WordAllRepository(resourcePath: nil)
        do {
            let _ = try await sut.randomWord()
            XCTFail("Unexpected success fetching random word")
        } catch {
            XCTAssertEqual(error as! WordRepositoryError, WordRepositoryError.wordsFileNotFound)
        }
    }

    func test_randomWord__throwsErrorWithEmptyWordsFile() async {
        let sut = WordAllRepository(resourcePath: pathForTextFile(named: "empty"))
        do {
            let _ = try await sut.randomWord()
            XCTFail("Unexpected success fetching random word")
        } catch {
            XCTAssertEqual(error as! WordRepositoryError, WordRepositoryError.randomWordNotFound)
        }
    }

    func test_definition_succeeds() async {
        let sut = WordAllRepository(service: MockWordService(detailsToReturn: mockWordDetails))
        do {
            let definitions = try await sut.definitions(for: "hello")
            XCTAssertNotNil(definitions)
            XCTAssertEqual(definitions?.first, mockDefinition)
        } catch {
            XCTFail("Unexpected failure fetching word definition")
        }
    }

    func test_definition_rethrowsNetworkErrors() async {
        let testCases: [(networkError: NetworkError, repoError: WordRepositoryError)] = [
            (networkError: .invalidURL, repoError: .networkError(.invalidURL)),
            (networkError: .networkError, repoError: .networkError(.networkError)),
            (networkError: .invalidResponse, repoError: .networkError(.invalidResponse)),
            (networkError: .unexpectedError(message: "Error"), repoError: .networkError(.unexpectedError(message: "Error")))
        ]

        for (networkError, repoError) in testCases {
            let sut = WordAllRepository(service: MockWordService(errorToThrow: networkError))
            do {
                let _ = try await sut.definitions(for: "hello")
                XCTFail("Unexpected success fetching word definition")
            } catch {
                XCTAssertEqual(error as! WordRepositoryError, repoError)
            }
        }
    }

    func test_definition_throwsUnexpectedError() async {
        let mockError = MockError()
        let sut = WordAllRepository(service: MockWordService(errorToThrow: mockError))
        do {
            let _ = try await sut.definitions(for: "hello")
            XCTFail("Unexpected success fetching word definition")
        } catch {
            XCTAssertEqual(error as! WordRepositoryError, .unexpectedError(message: mockError.localizedDescription))
        }
    }

    // MARK: Private Helpers

    private func pathForTextFile(named name: String) -> String? {
        Bundle(for: type(of: self)).path(forResource: name, ofType: "txt")
    }


}
