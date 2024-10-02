//
//  Constants.swift
//  HowCat
//
//  Created by Arviejhay Alejandro on 10/2/24.
//

enum CatServiceErrorText {
    static let badUrl = "badURL"
    static let networkError = "networkError"
    static let decodingError = "decodingError"
    static let generalError = "generalError"
    
    static let badUrlDescription = "Uh-oh! It seems we couldn't connect to the cat facts. Please try again later."
    static let networkErrorDescription = "Uh-oh! We're experiencing some cat trouble. Please check your internet connection and tap the screen again."
    static let decodingErrorDescription = "Uh-oh! It seems like our cat is having a little trouble finding a fact. Tap the screen again, and let's see if we can fetch one this time!"
    static let generalErrorDescription = "Oops! It seems the cats are taking a nap. Please try again later."
}

enum CatFactViewText {
    static let introduction = "A delightful app that offers random cat images and fun facts about cats with just a tap, perfect for feline enthusiasts! Tap anywhere on the screen to start getting facts about cats!"
    static let imageLabel = "A cat picture"
}
