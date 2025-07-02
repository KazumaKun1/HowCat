//
//  CatMainView.swift
//  HowCat
//
//  Created by Arviejhay Alejandro on 9/30/24.
//

import SwiftUI
import Kingfisher

struct CatMainView: View {
    @StateObject private var viewModel: CatMainViewModel
    
    init(catService: CatServiceProtocol) {
        _viewModel = StateObject(wrappedValue: CatMainViewModel(catService: catService))
    }
    
    var body: some View {
        ZStack {
            Color.accentColor
                .ignoresSafeArea(.all)
            
            switch viewModel.state {
            case .main:
                CatIntroView()
            case .factScreen(let fact):
                CatFactView(content: fact)
            case .errorScreen(let message):
                CatErrorView(errorMessage: message)
            }
            
            if viewModel.isLoading {
                VStack(spacing: 0) {
                    CatFactLoadingView()
                }
            }
        }
        .animation(.linear(duration: 0.5), value: viewModel.state)
        .animation(.easeInOut(duration: 0.5), value: viewModel.isLoading)
        .onAppear {
            KingfisherManager.shared.cache.diskStorage.config.sizeLimit = 0
        }
        .onTapGesture {
            if viewModel.isLoading {
                return
            }
            viewModel.cancelSubscriptions()
            KingfisherManager.shared.cache.clearCache()
            viewModel.fetchCatContent()
        }
        .accessibilityAddTraits(.isButton)
    }
}

#Preview {
    CatMainView(catService: MockCatService())
}
