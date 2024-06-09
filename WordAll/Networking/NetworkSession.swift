//
//  NetworkSession.swift
//  WordAll
//
//  Created by Ian Lockett on 07/06/2024.
//

import Foundation

protocol NetworkSession {
    func wordData(for: URLRequest) async throws -> Data
}

extension URLSession: NetworkSession {

    private var validStatus: ClosedRange<Int> {
        200...299
    }

    func wordData(for request: URLRequest) async throws -> Data {
        guard let (data, response) = try await self.data(for: request) as? (Data, HTTPURLResponse),
              validStatus.contains(response.statusCode) else {
            throw NetworkError.networkError
        }
        return data
    }
}
