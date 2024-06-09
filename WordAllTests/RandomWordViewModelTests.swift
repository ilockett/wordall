//
//  RandomWordViewModelTests.swift
//  WordAllTests
//
//  Created by Ian Lockett on 08/06/2024.
//

import XCTest
@testable import WordAll

final class RandomWordViewModelTests: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test_selectingRandomWord_succeedsWithNoError() async {
        let word = "thing"
        let sut = RandomWordViewModel(repository: MockWordRepository(wordToReturn: word))

        await sut.selectRandomWord()

        XCTAssertEqual(sut.selectedWord, word)
        XCTAssertNil(sut.error)
    }

    func test_selectingRandomWord_flagsErrorWhenRepoThrowsError() async {
        let sut = RandomWordViewModel(repository: MockWordRepository(errorToThrow: MockError()))

        await sut.selectRandomWord()

        XCTAssertNotNil(sut.error)
    }

    func test_shouldSelectNewWord_isTrueByDefault() async {
        let sut = RandomWordViewModel()

        XCTAssertTrue(sut.shouldSelectNewWord)
    }

    func test_shouldSelectNewWord_isFalseAfterSelectingAWord() async {
        let sut = RandomWordViewModel()

        let _ = await sut.selectRandomWord()

        XCTAssertFalse(sut.shouldSelectNewWord)
    }

}
