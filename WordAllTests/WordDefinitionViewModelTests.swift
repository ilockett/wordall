//
//  WordDefinitionViewModelTests.swift
//  WordAllTests
//
//  Created by Ian Lockett on 08/06/2024.
//

import XCTest
@testable import WordAll

final class WordDefinitionViewModelTests: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test_fetchDefinition_succeedsWithNoError() async {
        let sut = WordDefinitionViewModel(word: "thing", repository: MockWordRepository(definitionsToReturn: [mockDefinition]))

        await sut.fetchDefinition()

        XCTAssertEqual(sut.definitions?.first, mockDefinition)
        XCTAssertNil(sut.error)
    }

    func test_fetchDefinition_failsWithError() async {
        let sut = WordDefinitionViewModel(word: "thing", repository: MockWordRepository(errorToThrow: WordRepositoryError.networkError(.networkError)))

        await sut.fetchDefinition()

        XCTAssertNil(sut.definitions)
        XCTAssertNotNil(sut.error)
    }

}
