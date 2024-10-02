//
//  HowCatApp.swift
//  HowCat
//
//  Created by Arviejhay Alejandro on 9/30/24.
//

import SwiftUI

@main
struct HowCatApp: App {
    var body: some Scene {
        WindowGroup {
            CatMainView(catService: catService)
        }
    }
    
    private var catService: CatServiceProtocol {
#if DEBUG
        if ProcessInfo.processInfo.environment["USE_MOCK_SERVICE"] == "1" {
            let mockService = MockCatService()
            
            if let errorString = ProcessInfo.processInfo.environment["CAT_SERVICE_ERROR"],
               let error = CatServiceError(errorString: errorString) {
                mockService.errorToThrow = error
            }
            
            return mockService
        }
#endif
        
        return CatService()
    }
}
