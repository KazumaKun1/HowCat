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
}
