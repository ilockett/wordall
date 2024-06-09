//
//  Binding+IsNotNil.swift
//  WordAll
//
//  Created by Ian Lockett on 08/06/2024.
//

import Foundation
import SwiftUI

extension Binding {
    func isNotNil<T>() -> Binding<Bool> where Value == T? {
        .init {
            wrappedValue != nil
        } set: { _ in
            wrappedValue = nil
        }
    }
}
