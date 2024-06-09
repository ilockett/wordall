//
//  Fonts.swift
//  WordAll
//
//  Created by Ian Lockett on 06/06/2024.
//

import Foundation
import SwiftUI

public extension Font {

    private static let titleFontName = "LilitaOne"
    private static let bodyFontNameBold = "Oxygen-Bold"
    private static let bodyFontNameRegular = "Oxygen-Regular"
    private static let bodyFontNameLight = "Oxygen-Light"

    private static let largeFontSize: CGFloat = 20
    private static let mediumFontSize: CGFloat = 16
    private static let smallFontSize: CGFloat = 12

    static let titleLarge = custom(titleFontName, size: 42, relativeTo: .largeTitle)
    static let titleMedium =  custom(titleFontName, size: 34, relativeTo: .title)
    static let titleSmall =  custom(titleFontName, size: 24, relativeTo: .title2)

    static let bodyLargeRegular =  custom(bodyFontNameRegular, size: largeFontSize, relativeTo: .headline)
    static let bodyLargeLight =  custom(bodyFontNameLight, size: largeFontSize, relativeTo: .headline)
    static let bodyLargeBold =  custom(bodyFontNameBold, size: largeFontSize, relativeTo: .headline)

    static let bodyMediumRegular =  custom(bodyFontNameRegular, size: mediumFontSize, relativeTo: .subheadline)
    static let bodyMediumLight =  custom(bodyFontNameLight, size: mediumFontSize, relativeTo: .subheadline)
    static let bodyMediumBold =  custom(bodyFontNameBold, size: mediumFontSize, relativeTo: .subheadline)

    static let bodySmallRegular =  custom(bodyFontNameRegular, size: smallFontSize, relativeTo: .body)
    static let bodySmallLight =  custom(bodyFontNameLight, size: smallFontSize, relativeTo: .body)
    static let bodySmallBold =  custom(bodyFontNameBold, size: smallFontSize, relativeTo: .body)

    static func title(fontSize: CGFloat) -> Font {
        custom(titleFontName, size: fontSize, relativeTo: .title)
    }

}

#Preview {
        VStack(alignment: .leading, spacing: 6) {

                Text(verbatim: "titleLarge")
                    .font(.titleLarge)

                Text(verbatim: "titleMedium")
                    .font(.titleMedium)

                Text(verbatim: "titleSmall")
                    .font(.titleSmall)

                Text(verbatim: "bodyLargeRegular")
                    .font(.bodyLargeRegular)

                Text(verbatim: "bodyLargeLight")
                    .font(.bodyLargeLight)

                Text(verbatim: "bodyLargeBold")
                    .font(.bodyLargeBold)

                Text(verbatim: "bodyMediumRegular")
                    .font(.bodyMediumRegular)

                Text(verbatim: "bodyMediumLight")
                    .font(.bodyMediumLight)

                Text(verbatim: "bodyMediumBold")
                    .font(.bodyMediumBold)

                Text(verbatim: "bodySmallRegular")
                    .font(.bodySmallRegular)

                Text(verbatim: "bodySmallLight")
                    .font(.bodySmallLight)

                Text(verbatim: "bodySmallBold")
                    .font(.bodySmallBold)

        }
}

