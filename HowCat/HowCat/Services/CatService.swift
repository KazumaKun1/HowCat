//
//  CatService.swift
//  HowCat
//
//  Created by Arviejhay Alejandro on 9/30/24.
//

import Combine
import Foundation
import UIKit

protocol CatServiceProtocol {
    func fetchCatImage() -> AnyPublisher<[CatImageModel], Error>
    func fetchCatFact() -> AnyPublisher<CatFactModel, Error>
}

class CatService: CatServiceProtocol {
    private let apiLoader = APILoader()
    
    func fetchCatFact() -> AnyPublisher<CatFactModel, Error> {
        guard let url = URL(string: apiLoader.catFactAPI) else {
            return Fail(error: CatServiceError.badURL)
                .eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: CatFactModel.self, decoder: JSONDecoder())
            .mapError { error in
                if error is URLError {
                    return CatServiceError.networkError
                } else if error is DecodingError {
                    return CatServiceError.decodingError
                }
                
                return CatServiceError.generalError
            }
            .eraseToAnyPublisher()
    }
    
    func fetchCatImage() -> AnyPublisher<[CatImageModel], Error> {
        guard let url = URL(string: apiLoader.catImageAPI) else {
            return Fail(error: CatServiceError.badURL)
                .eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [CatImageModel].self, decoder: JSONDecoder())
            .mapError { error in
                if error is URLError {
                    return CatServiceError.networkError
                } else if error is DecodingError {
                    return CatServiceError.decodingError
                }
                
                return CatServiceError.generalError
            }
            .eraseToAnyPublisher()
    }
}
