//
//  CatMainView.swift
//  HowCat
//
//  Created by Arviejhay Alejandro on 9/30/24.
//

import SwiftUI
import Kingfisher

struct CatMainView: View {
    @StateObject private var viewModel = CatFactViewModel(catService: CatService())
    
    var body: some View {
        ZStack {
            Color.white
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
                    .onDisappear {
                        viewModel.cancellables.removeAll()
                        KingfisherManager.shared.cache.clearCache()
                    }
            }
        }
        .animation(.easeInOut(duration: 0.5), value: viewModel.catContent.isLoading)
        .onTapGesture {
            if !viewModel.catContent.isLoading {
                viewModel.fetchCatContent()
            }
        }
        .accessibilityAddTraits(.isButton)
    }
}

#Preview {
    CatMainView()
}
