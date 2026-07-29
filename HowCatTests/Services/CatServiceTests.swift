//
//  CatServiceTests.swift
//  HowCat
//
//  Created by Arviejhay Alejandro on 10/1/24.
//

import Testing
import Combine
import Foundation

@testable import HowCat

struct CatServiceTests {
    var sut: CatServiceProtocol
    
    init() {
        sut = MockCatService()
    }
    
    @Test("Mock cat service that returns the expected fact")
    func returnSuccessfulCatFact() async {
        let publisher = sut.fetchCatFact()
        var cancellables = Set<AnyCancellable>()
        await confirmation { confirmation in
            publisher
                .sink { result in
                    switch result {
                    case .finished:
                        #expect(true, "Cat Fact Publisher completed successfully")
                        confirmation()
                    case .failure(let error):
                        Issue.record("Cat Fact Publisher failed with error: \(error.localizedDescription)")
                    }
                } receiveValue: { model in
                    #expect(!model.data.isEmpty)
                }
                .store(in: &cancellables)
        }
    }

    @Test("Validate Cat Fact Service Errors", arguments: [
        CatServiceError.badURL,
        CatServiceError.networkError,
        CatServiceError.decodingError,
        CatServiceError.generalError
    ])
    func returnCatFactFailures(error: CatServiceError) async {
        (sut as! MockCatService).errorToThrow = error
        
        let publisher = sut.fetchCatFact()
        var cancellables = Set<AnyCancellable>()
        
        await confirmation { confirmation in
            publisher
                .sink { result in
                    switch result {
                    case .finished:
                        Issue.record(CatServiceError.generalError, "Cat Fact Publisher shouldn't complete successfully")
                    case .failure(let error):
                        #expect(!error.localizedDescription.isEmpty)
                        confirmation()
                    }
                } receiveValue: { _ in
                    Issue.record(CatServiceError.generalError, "This publisher completion shouldn't execute when it's failure")
                }
                .store(in: &cancellables)
        }
    }
    
    @Test("Validate Cat Image Service Errors", arguments: [
        CatServiceError.badURL,
        CatServiceError.networkError,
        CatServiceError.decodingError,
        CatServiceError.generalError
    ])
    func returnCatImageFailures(error: CatServiceError) async {
        (sut as! MockCatService).errorToThrow = error
        
        let publisher = sut.fetchCatFact()
        var cancellables = Set<AnyCancellable>()
        
        await confirmation { confirmation in
            publisher
                .sink { result in
                    switch result {
                    case .finished:
                        Issue.record(CatServiceError.generalError, "Cat Image Publisher shouldn't complete successfully")
                    case .failure(let error):
                        #expect(!error.localizedDescription.isEmpty)
                        confirmation()
                    }
                } receiveValue: { _ in
                    Issue.record(CatServiceError.generalError, "This publisher completion shouldn't execute when it's failure")
                }
                .store(in: &cancellables)
        }
    }
    
    @Test("Mock cat service that returns the expected cat image url")
    func returnSuccessfulCatImage() async {
        let publisher = sut.fetchCatImage()
        var cancellables = Set<AnyCancellable>()
        await confirmation { confirmation in
            publisher
                .sink { result in
                    switch result {
                    case .finished:
                        #expect(true, "Cat Image Publisher completed successfully")
                        confirmation()
                    case .failure(let error):
                        Issue.record("Cat Image Publisher failed with error: \(error.localizedDescription)")
                    }
                } receiveValue: { model in
                    let urlString = model.url
                    #expect(urlString == MockData.sampleImageUrl, "The url provided is not the expected url")
                    #expect(URL(string: urlString) != nil, "The provided url is not a valid url")
                }
                .store(in: &cancellables)
        }
    }
}
