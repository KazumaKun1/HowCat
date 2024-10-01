//
//  MockCatService.swift
//  HowCat
//
//  Created by Arviejhay Alejandro on 10/1/24.
//
import Combine
@testable import HowCat

class MockCatService: CatServiceProtocol {
    
    private var mockCatImage: [CatImageModel]
    private var mockCatFact: CatFactModel
    
    var errorToThrow: CatServiceError?
    
    init() {
        mockCatImage = [CatImageModel(url: "https://google.com/")]
        mockCatFact = CatFactModel(data: ["This is a fact"])
    }
    
    func fetchCatFact() -> AnyPublisher<CatFactModel, any Error> {
        if let error = errorToThrow {
            return Fail(error: error).eraseToAnyPublisher()
        }
        
        return Just(mockCatFact)
            .setFailureType(to: CatServiceError.self)
            .mapError { $0 as Error }
            .eraseToAnyPublisher()
    }
    
    func fetchCatImage() -> AnyPublisher<[CatImageModel], any Error> {
        if let error = errorToThrow {
            return Fail(error: error).eraseToAnyPublisher()
        }
        
        return Just(mockCatImage)
            .setFailureType(to: CatServiceError.self)
            .mapError { $0 as Error }
            .eraseToAnyPublisher()
    }
}
