//
//  WordAllServiceTests.swift
//  WordAllTests
//
//  Created by Ian Lockett on 08/06/2024.
//

import XCTest
@testable import WordAll

final class WordAllServiceTests: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test_fetchDefinition_succeeds() async throws {
        let sut = WordAllService(networkSession: MockNetworkSession(jsonResponseFileName: "word_response_valid"))
        do {
            let details = try await sut.fetchDetails(word: "hello")
            XCTAssertNotNil(details)
            XCTAssertEqual(details.definitions?.count, 1)
        } catch {
            XCTFail("Unexpected failure when fetching definition")
        }
    }

    func test_fetchDefinition_throwsErrorWithInvalidJSON() async throws {
        let sut = WordAllService(networkSession: MockNetworkSession(jsonResponseFileName: "word_response_invalid"))
        do {
            let _ = try await sut.fetchDetails(word: "hello")
            XCTFail("Unexpected success when fetching definition")
        } catch {
            XCTAssertEqual(error as! NetworkError, NetworkError.invalidResponse)
        }
    }

    func test_fetchDefinition_throwsErrorWithSessionNetworkError() async throws {
        let sut = WordAllService(networkSession: MockNetworkSession(errorToThrow: NetworkError.networkError))
        do {
            let _ = try await sut.fetchDetails(word: "hello")
            XCTFail("Unexpected success when fetching definition")
        } catch {
            XCTAssertEqual(error as! NetworkError, NetworkError.networkError)
        }
    }



}
