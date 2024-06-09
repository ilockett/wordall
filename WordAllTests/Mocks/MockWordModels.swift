//
//  MockWordModels.swift
//  WordAllTests
//
//  Created by Ian Lockett on 08/06/2024.
//

import Foundation
@testable import WordAll

let mockWordDetails = WordDetails(definitions: [mockDefinition])

let mockDefinition = Definition(definition: "an expression of greeting",
                                partOfSpeech: "noun",
                                synonyms: ["hi", "how-do-you-do", "howdy", "hullo"],
                                typeOf: ["greeting", "salutation"],
                                derivation: nil)
