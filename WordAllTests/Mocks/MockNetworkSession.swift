//
//  MockNetworkSession.swift
//  WordAllTests
//
//  Created by Ian Lockett on 08/06/2024.
//

import Foundation
@testable import WordAll

class MockNetworkSession: NetworkSession {

    private var jsonFileName: String?
    private var errorToThrow: Error?

    convenience init(jsonResponseFileName: String) {
        self.init()
        self.jsonFileName = jsonResponseFileName
    }

    convenience init(errorToThrow: Error) {
        self.init()
        self.errorToThrow = errorToThrow
    }

    func wordData(for: URLRequest) async throws -> Data {
        try await Task.sleep(for: .milliseconds(Int.random(in: 100...300)))
        if let errorToThrow {
            throw errorToThrow
        }
        return jsonData()
    }

    private func jsonData() -> Data {
        let url = Bundle(for: type(of: self)).url(forResource: jsonFileName, withExtension: "json")!
        return try! Data(contentsOf: url)
    }
}
