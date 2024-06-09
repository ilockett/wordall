//
//  WordInfoDestination.swift
//  WordAll
//
//  Created by Ian Lockett on 08/06/2024.
//

import Foundation

enum WordInfoDestination: String, CoordinatorDestination {
    case rhymingWords
    case examples

    var id: String {
        rawValue
    }
}
