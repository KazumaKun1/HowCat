//
//  CatFactViewModel.swift
//  HowCat
//
//  Created by Arviejhay Alejandro on 9/30/24.
//

import Combine
import SwiftUI

class CatFactViewModel: ObservableObject {
    private var catService: CatServiceProtocol
    var cancellables = Set<AnyCancellable>()
    
    @Published var catContent: CatContentModel = CatContentModel(isLoading: false)
    
    init(catService: CatServiceProtocol) {
        self.catService = catService
    }
    
    func fetchCatContent() {
        catContent.errorMessage = nil
        catContent.isLoading = true
        
        let catFactPublisher = catService.fetchCatFact()
        let catImagePublisher = catService.fetchCatImage()
        
        Publishers.Zip(catImagePublisher, catFactPublisher)
            .receive(on: DispatchQueue.main)
            .timeout(.seconds(10), scheduler: DispatchQueue.main)
            .delay(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self else { return }
                
                switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        self.catContent = CatContentModel(errorMessage: error.localizedDescription,
                                                          isLoading: false)
                        break
                }
            }, receiveValue: { [weak self] imageModels, fact in
                guard let self else { return }
                
                self.catContent = CatContentModel(fact: fact.data.first,
                                                  imageUrl: URL(string: imageModels.first?.url ?? ""),
                                                  isLoading: false)
            })
            .store(in: &cancellables)
    }
}

