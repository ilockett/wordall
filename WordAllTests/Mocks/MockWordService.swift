//
//  MockWordService.swift
//  WordAllTests
//
//  Created by Ian Lockett on 08/06/2024.
//

import Foundation
@testable import WordAll

class MockWordService: WordService {

    required init(networkSession: NetworkSession = MockNetworkSession(), apiKey: String = "") {
    }

    convenience init(detailsToReturn: WordDetails) {
        self.init()
        self.detailsToReturn = detailsToReturn
    }

    convenience init(errorToThrow: Error) {
        self.init()
        self.errorToThrow = errorToThrow
    }

    private var detailsToReturn: WordDetails?

    private var errorToThrow: Error?

    func fetchDetails(word: String) async throws -> WordDetails {
        if let errorToThrow {
            throw errorToThrow
        }
        return detailsToReturn!
    }

}
