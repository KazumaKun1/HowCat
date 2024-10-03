//
//  CatFactViewModel.swift
//  HowCat
//
//  Created by Arviejhay Alejandro on 10/3/24.
//

import SwiftUI

class CatFactViewModel: ObservableObject {
    @Published var isSavingSuccessful = false
    @Published var isShowingAlert = false
    
    var loadedImage: UIImage?
    
    private lazy var availableFonts: [String] = {
        getAvailableFonts()
    }()
    
    func getAdaptiveFont(isRandomized: Bool, _ horizontalSizeClass: UserInterfaceSizeClass?) -> Font {
        if horizontalSizeClass == .regular {
            return isRandomized ? .custom(randomFont(), size: 35, relativeTo: .largeTitle) : .largeTitle
        } else {
            return isRandomized ? .custom(randomFont(), size: 20, relativeTo: .title3) : .title3
        }
    }
    
    private func getAvailableFonts() -> [String] {
        var fontNames: [String] = []
        for family in UIFont.familyNames {
            let names = UIFont.fontNames(forFamilyName: family)
            fontNames.append(contentsOf: names)
        }
        
        return fontNames
    }
    
    private func randomFont() -> String {
        return availableFonts.randomElement() ?? "System"
    }
}
