//
//  NetworkError.swift
//  WordAll
//
//  Created by Ian Lockett on 07/06/2024.
//

import Foundation

enum NetworkError: Error, Equatable {
    case invalidURL
    case networkError
    case invalidResponse
    case unexpectedError(message: String)
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            "We were unable to connect due to an invalid URL."
        case .networkError, .invalidResponse:
            "There was an unexpected error fetching data over the network."
        case .unexpectedError(let message):
            "Something unexpected happened:\n\n\(message)"
        }
    }
}
