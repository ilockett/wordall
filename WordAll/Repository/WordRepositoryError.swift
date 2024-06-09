//
//  WordRepositoryError.swift
//  WordAll
//
//  Created by Ian Lockett on 08/06/2024.
//

import Foundation

enum WordRepositoryError: Error, Equatable {
    case wordsFileNotFound
    case randomWordNotFound
    case networkError(NetworkError)
    case unexpectedError(message: String)
}

extension WordRepositoryError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .wordsFileNotFound:
            "We were unable to load the words file."
        case .randomWordNotFound:
            "We were unable to select a random word."
        case .networkError(let error):
            error.errorDescription
        case .unexpectedError(let message):
            "Something unexpected happened:\n\n\(message)"
        }
    }
}
