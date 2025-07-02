//
//  CatFactViewModel.swift
//  HowCat
//
//  Created by Arviejhay Alejandro on 9/30/24.
//

import Combine
import SwiftUI

class CatMainViewModel: ObservableObject {
    private var catService: CatServiceProtocol
    var cancellables = Set<AnyCancellable>()
    
    @Published var state: CatScreenState = .main
    @Published var isLoading: Bool = false
    
    init(catService: CatServiceProtocol) {
        self.catService = catService
    }
    
    func fetchCatContent() {
        isLoading = true
        
        let catFactPublisher = catService.fetchCatFact()
        let catImagePublisher = catService.fetchCatImage()
        
        Publishers.Zip(catImagePublisher, catFactPublisher)
            .receive(on: DispatchQueue.main)
            .timeout(.seconds(10), scheduler: DispatchQueue.main)
            .delay(for: .seconds(1), scheduler: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self else { return }
                self.isLoading = false
                switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        self.state = .errorScreen(message: error.localizedDescription)
                        break
                }
            }, receiveValue: { [weak self] imageModels, fact in
                self?.isLoading = false
                guard let self,
                      let factText = fact.data.first,
                      let imageUrl = URL(string: imageModels.first?.url ?? "") else {
                    self?.state = .errorScreen(message: CatServiceErrorText.generalError)
                    return
                }
                self.state = .factScreen(content: CatContent(fact: factText, imageUrl: imageUrl))
            })
            .store(in: &cancellables)
    }
    
    func cancelSubscriptions() {
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
    }
}

