//
//  UITestWordRepository.swift
//  WordAll
//
//  Created by Ian Lockett on 08/06/2024.
//

import Foundation

#if DEBUG

class UITestWordRepository: WordRepository {
    required init(resourcePath: String? = nil, service: any WordService = UITestWordService()) {
    }
    
    func randomWord() async throws -> String {
        "hello"
    }
    
    func definitions(for word: String) async throws -> [Definition]? {
        mockWordDetails.definitions
    }
}

private class UITestWordService: WordService {
    required init(networkSession: any NetworkSession = UITestNetworkSession(), apiKey: String = "") {
    }
    
    func fetchDetails(word: String) async throws -> WordDetails {
        mockWordDetails
    }
}

private class UITestNetworkSession: NetworkSession {
    func wordData(for: URLRequest) async throws -> Data {
        "".data(using: .utf8)!
    }
}

private let mockWordDetails = WordDetails(definitions: [mockDefinition])

private let mockDefinition = Definition(definition: "an expression of greeting",
                                        partOfSpeech: "noun",
                                        synonyms: ["hi", "how-do-you-do", "howdy", "hullo"],
                                        typeOf: ["greeting", "salutation"],
                                        derivation: nil)

#endif
