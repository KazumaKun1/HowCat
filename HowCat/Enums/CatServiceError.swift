//
//  CatServiceError.swift
//  HowCat
//
//  Created by Arviejhay Alejandro on 9/30/24.
//

import Foundation

enum CatServiceError: Error {
    case badURL
    case networkError
    case decodingError
    case generalError
}

extension CatServiceError: LocalizedError {
    var errorDescription: String? {
        switch self {
            case .badURL:
                return "Uh-oh! It seems we couldn't connect to the cat facts. Please try again later."
            case .networkError:
                return "Uh-oh! We're experiencing some cat trouble. Please check your internet connection and tap the screen again."
            case .decodingError:
                return "Uh-oh! It seems like our cat is having a little trouble finding a fact. Tap the screen again, and let's see if we can fetch one this time!"
            case .generalError:
                return "Oops! It seems the cats are taking a nap. Please try again later."
        }
    }
}

