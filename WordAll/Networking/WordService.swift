//
//  WordService.swift
//  WordAll
//
//  Created by Ian Lockett on 07/06/2024.
//

import Foundation

protocol WordService {
    init(networkSession: NetworkSession, apiKey: String)
    func fetchDetails(word: String) async throws -> WordDetails
}

class WordAllService: WordService {

    private let networkSession: NetworkSession
    private let apiKey: String
    private let decoder = JSONDecoder()

    private let baseURLString = "https://wordsapiv1.p.rapidapi.com/words/"

    #warning("Don't forget to add the Words API key here...")
    required init(networkSession: NetworkSession = URLSession.shared,
                  apiKey: String = "<#Enter API Key#>") {
        self.networkSession = networkSession
        self.apiKey = apiKey
    }

    private enum RequestType {
        case definition(word: String)

        var path: String {
            switch self {
            case .definition(let word):
                "\(word)"
            }
        }
    }

    func fetchDetails(word: String) async throws -> WordDetails {
        let request = try urlRequest(type: .definition(word: word))
        let data = try await networkSession.wordData(for: request)
        do {
            return try decoder.decode(WordDetails.self, from: data)
        } catch {
            throw NetworkError.invalidResponse
        }
    }

    private func url(requestType: RequestType) throws -> URL {
        guard let apiURL = URL(string: "\(baseURLString)\(requestType.path)") else {
            throw NetworkError.invalidURL
        }
        return apiURL
    }

    private func urlRequest(type: RequestType) throws -> URLRequest {
        var urlRequest = URLRequest(url: try url(requestType: type))
        urlRequest.httpMethod = "GET"
        urlRequest.addValue(apiKey, forHTTPHeaderField: "x-rapidapi-key")
        urlRequest.addValue("wordsapiv1.p.rapidapi.com", forHTTPHeaderField: "x-rapidapi-host")
        return urlRequest
    }
}
