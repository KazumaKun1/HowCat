//  FontHelper.swift
//  HowCat
//
//  Created by Refactor Bot on 7/2/25.

import SwiftUI

enum FontHelper {
    static let availableFonts: [String] = getAvailableFonts()

    static func getAdaptiveFont(isRandomized: Bool, horizontalSizeClass: UserInterfaceSizeClass?) -> Font {
        let isRegular = horizontalSizeClass == .regular

        guard isRandomized, let fontName = randomFont() else {
            return isRegular ? .largeTitle : .title3
        }

        let size: CGFloat = isRegular ? 35 : 20
        let textStyle: Font.TextStyle = isRegular ? .largeTitle : .title3
        return .custom(fontName, size: size, relativeTo: textStyle)
    }

    private static func getAvailableFonts() -> [String] {
        UIFont.familyNames
            .filter { !$0.hasPrefix(".") && !excludedFamilies.contains($0) }
            .flatMap { UIFont.fontNames(forFamilyName: $0) }
    }

    private static let excludedFamilies: Set<String> = [
        "Apple Color Emoji",
        "Bodoni Ornaments",
        "Zapf Dingbats",
        "Webdings",
        "Wingdings"
    ]

    private static func randomFont() -> String? {
        availableFonts.randomElement()
    }
}
