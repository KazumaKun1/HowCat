//
//  CatFactViewModelTests.swift
//  HowCat
//
//  Created by Arviejhay Alejandro on 10/1/24.
//

import XCTest
import Combine

@testable import HowCat

class CatFactViewModelTests: XCTestCase {
    var sut: CatFactViewModel!
    var mockCatService: CatServiceProtocol!
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        
        mockCatService = MockCatService()
        sut = CatFactViewModel(catService: mockCatService)
        cancellables = Set<AnyCancellable>()
    }
    
    override func tearDown() {
        sut = nil
        mockCatService = nil
        cancellables = nil
        super.tearDown()
    }
    
    func testViewModel_ReturnCatFactImage() {
        let expectation = XCTestExpectation(description: "Test Cat Fact View model with mock cat service to retrieve the cat fact and image")
        
        sut.fetchCatContent()
        
        sut.$catContent
            .dropFirst()
            .sink { content in
                let link = "https://google.com/"
                
                XCTAssertEqual(content.fact, "This is a fact", "The fact provided is not the expected fact")
                XCTAssertEqual(content.imageUrl, URL(string: link), "The image url is not the expected url")
                XCTAssertEqual(content.imageUrl?.absoluteString, link, "The image url string is not the expected url string")
                
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testViewModel_ReturnFailures() {
        let errorDictionary: [CatServiceError: String] = [.badURL: "Test Cat Fact View model with mock cat service set to bad url error, return error message and both fact and image are nil",
                                                     .networkError: "Test Cat Fact View model with mock cat service set to network error, return error message and both fact and image are nil",
                                                     .decodingError: "Test Cat Fact View model with mock cat service set to decoding error, return error message and both fact and image are nil",
                                                     .generalError: "Test Cat Fact View model with mock cat service set to general error, return error message and both fact and image are nil"]
        
        for (error, description) in errorDictionary {
            let expectation = XCTestExpectation(description: description)
            
            (mockCatService as! MockCatService).errorToThrow = error
            
            let tempSUT = CatFactViewModel(catService: mockCatService)
            
            tempSUT.fetchCatContent()
            
            tempSUT.$catContent
                .dropFirst()
                .sink { content in
                    XCTAssertNotNil(content.errorMessage, "The error message should exist when throwing an error")
                    XCTAssertNil(content.fact, "The fact must be nil or blank when an error occured")
                    XCTAssertNil(content.imageUrl, "The imageUrl must be nil or blank when an error occured")
                    
                    expectation.fulfill()
                }
                .store(in: &cancellables)
            
            wait(for: [expectation], timeout: 3.0)
        }
    }
}
