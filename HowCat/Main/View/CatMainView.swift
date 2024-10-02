//
//  CatMainView.swift
//  HowCat
//
//  Created by Arviejhay Alejandro on 9/30/24.
//

import SwiftUI
import Kingfisher

struct CatMainView: View {
    @StateObject private var viewModel: CatFactViewModel
    
    init(catService: CatServiceProtocol) {
        _viewModel = StateObject(wrappedValue: CatFactViewModel(catService: catService))
    }
    
    var body: some View {
        ZStack {
            Color.accentColor
                .ignoresSafeArea(.all)
            
            CatFactView(fact: viewModel.catContent.fact, imageUrl: viewModel.catContent.imageUrl)
                .transition(.opacity)
            
            if let message = viewModel.catContent.errorMessage {
                CatErrorView(errorMessage: message)
                    .transition(.opacity)
            }
            
            if viewModel.catContent.isLoading {
                CatFactLoadingView()
                    .transition(.opacity)
 
            }
        }
        .animation(.easeInOut(duration: 0.5), value: viewModel.catContent.isLoading)
        .onAppear {
            KingfisherManager.shared.cache.diskStorage.config.sizeLimit = 0
        }
        .onTapGesture {
            if !viewModel.catContent.isLoading {
                viewModel.cancellables.removeAll()
                KingfisherManager.shared.cache.clearCache()
                
                viewModel.fetchCatContent()
            }
        }
        .accessibilityAddTraits(.isButton)
    }
}

#Preview {
    CatMainView(catService: MockCatService())
}
