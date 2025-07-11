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
            
            ZStack {
                if case .main = viewModel.state {
                    CatIntroView()
                        .transition(.move(edge: .leading))
                }
                if case .factScreen(let fact) = viewModel.state {
                    CatFactView(content: fact)
                }
            }
            .animation(.easeInOut(duration: 0.5), value: viewModel.state)
            
            if viewModel.isLoading {
                CatFactLoadingView()
            }
        }
        .animation(.easeInOut(duration: 0.5), value: viewModel.isLoading)
        .onAppear {
            KingfisherManager.shared.cache.diskStorage.config.sizeLimit = 0
        }
        .onTapGesture {
            if !viewModel.isLoading {
                viewModel.cancelSubscriptions()
                KingfisherManager.shared.cache.clearCache()
                
                viewModel.fetchCatContent()
            }
        }
        .alert("Error", isPresented: Binding(
            get: { viewModel.errorMessage != nil },
            set: { newValue in
                if !newValue { viewModel.errorMessage = nil }
            }
        )) {
            Button("Ok", role: .cancel) { }
        } message: {
            Text(viewModel.errorMessage ?? CatServiceError.generalError.localizedDescription)
        }
        .accessibilityAddTraits(.isButton)
    }
}

#Preview {
    CatMainView(catService: MockCatService())
}
