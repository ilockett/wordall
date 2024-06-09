//
//  RootDestination.swift
//  WordAll
//
//  Created by Ian Lockett on 08/06/2024.
//

import Foundation

enum RootDestination: CoordinatorDestination {
    case home
    case about
    case wordInfo(String)

    var id: String {
        switch self {
        case .home:
            "home"
        case .about:
            "about"
        case .wordInfo(let word):
            "wordinfo-\(word)"
        }
    }
}
