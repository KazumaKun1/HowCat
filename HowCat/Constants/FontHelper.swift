//  FontHelper.swift
//  HowCat
//
//  Created by Refactor Bot on 7/2/25.

import SwiftUI

struct FontHelper {
    static var availableFonts: [String] = {
        getAvailableFonts()
    }()
    
    static func getAdaptiveFont(isRandomized: Bool, horizontalSizeClass: UserInterfaceSizeClass?) -> Font {
        if horizontalSizeClass == .regular {
            return isRandomized ? .custom(randomFont(), size: 35, relativeTo: .largeTitle) : .largeTitle
        } else {
            return isRandomized ? .custom(randomFont(), size: 20, relativeTo: .title3) : .title3
        }
    }
    
    private static func getAvailableFonts() -> [String] {
        var fontNames: [String] = []
        for family in UIFont.familyNames {
            let names = UIFont.fontNames(forFamilyName: family)
            fontNames.append(contentsOf: names)
        }
        return fontNames
    }
    
    private static func randomFont() -> String {
        return availableFonts.randomElement() ?? "System"
    }
}
