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
    
    init?(errorString: String) {
        switch errorString {
        case CatServiceErrorText.badUrl:
            self = .badURL
        case CatServiceErrorText.networkError:
            self = .networkError
        case CatServiceErrorText.decodingError:
            self = .decodingError
        case CatServiceErrorText.generalError:
            self = .generalError
        default:
            return nil
        }
    }
}

extension CatServiceError: LocalizedError {
    var errorDescription: String? {
        switch self {
            case .badURL:
                return CatServiceErrorText.badUrlDescription
            case .networkError:
                return CatServiceErrorText.networkErrorDescription
            case .decodingError:
                return CatServiceErrorText.decodingErrorDescription
            case .generalError:
                return CatServiceErrorText.generalErrorDescription
        }
    }
}

