//
//  HowCatUITests.swift
//  HowCatUITests
//
//  Created by Arviejhay Alejandro on 10/2/24.
//

import XCTest
import Foundation

class HowCatUITests: XCTestCase {
    
    private var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        
        app = XCUIApplication()
    }

    override func tearDownWithError() throws {
        app = nil
    }

    @MainActor
    func testTapTheStartScreen_ShouldShowCatFact() throws {
        app.launchEnvironment = [
            "USE_MOCK_SERVICE": "1"
        ]
        
        app.launch()
        
        let introductionLabel = app.buttons["introductionLabel"]
        
        let middleOfScreen = app.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5))
        middleOfScreen.tap()
        
        let factLabel = app.buttons["factLabel"]
        
        let isExist = factLabel.waitForExistence(timeout: 5)
        
        if !isExist {
            XCTFail("Cat fact didn't appear on time")
        }
        
        XCTAssertFalse(introductionLabel.exists, "The introduction screen is still present")
        XCTAssertEqual(factLabel.label, "This is a fact", "The fact shown on the screen is not the expected fact")
    }
    
    @MainActor
    func testTapTheStartScreen_ShouldShowErrorOnBadURL() throws {
        app.launchEnvironment = [
            "USE_MOCK_SERVICE": "1",
            "CAT_SERVICE_ERROR": CatServiceErrorText.badUrl
        ]
        
        app.launch()
        
        let middleOfScreen = app.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5))
        middleOfScreen.tap()
        
        let errorLabel = app.buttons["errorLabel"]
        
        let isExist = errorLabel.waitForExistence(timeout: 5)
        
        if !isExist {
            XCTFail("Cat Error BadURL didn't appear on time")
        }
        
        XCTAssertEqual(errorLabel.label, CatServiceErrorText.badUrlDescription, "The error shown on the screen is not the expected error for badURL")
    }
    
    @MainActor
    func testTapTheStartScreen_ShouldShowErrorOnNetworkError() throws {
        app.launchEnvironment = [
            "USE_MOCK_SERVICE": "1",
            "CAT_SERVICE_ERROR": CatServiceErrorText.networkError
        ]
        
        app.launch()
        
        let middleOfScreen = app.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5))
        middleOfScreen.tap()
        
        let errorLabel = app.buttons["errorLabel"]
        
        let isExist = errorLabel.waitForExistence(timeout: 5)
        
        if !isExist {
            XCTFail("Cat Error NetworkError didn't appear on time")
        }
        
        XCTAssertEqual(errorLabel.label, CatServiceErrorText.networkErrorDescription, "The error shown on the screen is not the expected error for NetworkError")
    }
    
    @MainActor
    func testTapTheStartScreen_ShouldShowErrorOnDecodingError() throws {
        app.launchEnvironment = [
            "USE_MOCK_SERVICE": "1",
            "CAT_SERVICE_ERROR": CatServiceErrorText.decodingError
        ]
        
        app.launch()
        
        let middleOfScreen = app.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5))
        middleOfScreen.tap()
        
        let errorLabel = app.buttons["errorLabel"]
        
        let isExist = errorLabel.waitForExistence(timeout: 5)
        
        if !isExist {
            XCTFail("Cat Error DecodingError didn't appear on time")
        }
        
        XCTAssertEqual(errorLabel.label, CatServiceErrorText.decodingErrorDescription, "The error shown on the screen is not the expected error for DecodingError")
    }
    
    @MainActor
    func testTapTheStartScreen_ShouldShowErrorOnGeneralError() throws {
        app.launchEnvironment = [
            "USE_MOCK_SERVICE": "1",
            "CAT_SERVICE_ERROR": CatServiceErrorText.generalError
        ]
        
        app.launch()
        
        let middleOfScreen = app.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5))
        middleOfScreen.tap()
        
        let errorLabel = app.buttons["errorLabel"]
        
        let isExist = errorLabel.waitForExistence(timeout: 5)
        
        if !isExist {
            XCTFail("Cat Error GeneralError didn't appear on time")
        }
        
        XCTAssertEqual(errorLabel.label, CatServiceErrorText.generalErrorDescription, "The error shown on the screen is not the expected error for GeneralError")
    }
}
