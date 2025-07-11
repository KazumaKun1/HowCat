//
//  CatFactViewModel.swift
//  HowCat
//
//  Created by Arviejhay Alejandro on 9/30/24.
//

import Combine
import SwiftUI

@MainActor
class CatMainViewModel: AsyncViewModel {
    private var catService: CatServiceProtocol
    
    @Published var state: CatMainViewScreenState = .main
    
    init(catService: CatServiceProtocol) {
        self.catService = catService
        super.init()
    }
    
    func fetchCatContent() {
        isLoading = true
        
        let catFactPublisher = catService.fetchCatFact()
        let catImagePublisher = catService.fetchCatImage()
        
        Publishers.Zip(catImagePublisher, catFactPublisher)
            .receive(on: DispatchQueue.main)
            .timeout(.seconds(10), scheduler: DispatchQueue.main)
            .delay(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self else { return }
                self.isLoading = false
                
                switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        self.errorMessage = error.localizedDescription
                        break
                }
            }, receiveValue: { [weak self] imageModels, fact in
                guard let self,
                      let factText = fact.data.first,
                      let imageUrl = URL(string: imageModels.first?.url ?? "") else {
                    self?.errorMessage = CatServiceErrorText.generalError
                    return
                }
                self.isLoading = false
                
                self.state = .factScreen(content: CatContentModel(fact: factText, imageUrl: imageUrl))
            })
            .store(in: &cancellables)
    }
}

