//
//  CatViewModel.swift
//  HowCat
//
//  Created by Arviejhay Alejandro on 10/3/24.
//

import SwiftUI
import Combine

class CatViewModel: ObservableObject {
    @Published var content: CatContentModel = CatContentModel(fact: "", imageUrl: URL(string: "https://www.google.com")!)
    @Published var isLoading = false
    
    private let catService: CatServiceProtocol
    
    private var cancellables = Set<AnyCancellable>()
    
    let navigationTrigger = PassthroughSubject<AppRoute, Never>()
    lazy var dedupedNavigationTrigger: AnyPublisher<AppRoute, Never> = navigationTrigger.removeDuplicates().eraseToAnyPublisher()
    
    let alertTrigger = PassthroughSubject<AlertConfig, Never>()
    
    let screenTappedSubject = PassthroughSubject<Void, Never>()
    
    init(catService: CatServiceProtocol) {
        self.catService = catService
        setupPipeline()
    }
}

private extension CatViewModel {
    func setupPipeline() {
        screenTappedSubject
            .flatMap { [weak self, catService] _ in
                self?.isLoading = true
                return catService.fetchCatFact()
                    .zip(catService.fetchCatImage())
                    .receive(on: DispatchQueue.main)
                    .handleEvents(receiveCompletion: { _ in
                        self?.isLoading = false
                    }, receiveCancel: {
                        self?.isLoading = false
                    })
                    .map { catFact, catImage in
                        Result<(CatFactModel, CatImageModel), Error>
                            .success((catFact, catImage))
                    }
                    .catch { error in
                        Just(.failure(error))
                    }
                    .eraseToAnyPublisher()
            }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] result in
                guard let self else { return }
                switch result {
                case .success((let fact, let image)):
                    self.handleSuccess(fact: fact, image: image)
                case .failure:
                    self.handleError()
                }
            }
            .store(in: &cancellables)
    }
}

private extension CatViewModel {
    func handleSuccess(fact: CatFactModel, image: CatImageModel) {
        guard let imageUrl = URL(string: image.url) else {
            handleError()
            return
        }
        
        content = CatContentModel(fact: fact.data.first ?? "", imageUrl: imageUrl)
        
        navigationTrigger.send(.fact)
    }
    
    func handleError() {
        let errorConfig = AlertConfig(
            title: "Cat API Down",
            message: "Please try again later.",
            primaryButtonText: "Retry",
            action: { [weak self] in self?.screenTappedSubject.send() })
        
        alertTrigger.send(errorConfig)
    }
}
