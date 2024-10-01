//
//  APILoader.swift
//  HowCat
//
//  Created by Arviejhay Alejandro on 10/1/24.
//

import Foundation

class APILoader {
    private let languageMapping: [String: String] = [
        "ben": "ben",
        "cs": "ces",
        "en": "eng",
        "es": "esp",
        "fil": "fil",
        "fr": "fra",
        "de": "ger",
        "it": "ita",
        "ko": "kor",
        "pt": "por",
        "ru": "rus",
        "uk": "ukr",
        "ur": "urd",
        "zh": "zho"
    ]
    
    var catImageAPI: String {
        "https://api.thecatapi.com/v1/images/search"
    }
    
    var catFactAPI: String {
        let language = Locale.preferredLanguages.first
        let languageCode = language?.split(separator: "-").first ?? "en"
        let apiLanguage = languageMapping[String(languageCode)] ?? languageMapping["en"]
        
        return "https://meowfacts.herokuapp.com/?lang=\(apiLanguage ?? "en")"
    }
}
