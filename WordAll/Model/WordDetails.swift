//
//  WordDetails.swift
//  WordAll
//
//  Created by Ian Lockett on 07/06/2024.
//

import Foundation

struct WordDetails: Decodable, Equatable {
    let definitions: [Definition]?

    enum CodingKeys: String, CodingKey {
        case definitions = "results"
    }
}

struct Definition: Decodable, Equatable {
    let definition: String
    let partOfSpeech: String
    let synonyms: [String]?
    let typeOf: [String]?
    let derivation: [String]?
}
