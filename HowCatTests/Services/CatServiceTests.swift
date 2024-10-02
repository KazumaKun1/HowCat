//
//  CatServiceTests.swift
//  HowCat
//
//  Created by Arviejhay Alejandro on 10/1/24.
//

import XCTest
import Combine

@testable import HowCat

class CatServiceTests: XCTestCase {
    var sut: CatServiceProtocol!
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        
        sut = MockCatService()
        cancellables = Set<AnyCancellable>()
    }
    
    override func tearDown() {
        sut = nil
        cancellables = nil
        
        super.tearDown()
    }
    
    func testRetrieveCatFact_ReturnSuccessfulFact() {
        let expectation = XCTestExpectation(description: "Mock cat service that returns the expected fact")
        
        sut.fetchCatFact()
            .sink { completion in
                switch completion {
                    case .finished:
                        XCTAssertTrue(true, "Cat Fact Publisher completed successfully")
                        break
                    case .failure(let error):
                        XCTFail("Cat Fact Publisher failed with error: \(error.localizedDescription)")
                        break
                }
                expectation.fulfill()
            } receiveValue: { model in
                XCTAssertEqual(model.data.first, "This is a fact", "Retrieved Cat Fact is not equal to the expected")
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testRetrieveCatFact_ReturnFailures() {
        let errorDictionary: [CatServiceError: String] = [.badURL: "Mock cat service retrieving fact to fail for bad url error",
                                                     .networkError: "Mock cat service retrieving fact to fail for network error",
                                                     .decodingError: "Mock cat service retrieving fact to fail for decoding error",
                                                     .generalError: "Mock cat service retrieving fact to fail for general error"]
        for (error, description) in errorDictionary {
            (sut as! MockCatService).errorToThrow = error
            
            let expectation = XCTestExpectation(description: description)
            
            sut.fetchCatFact()
                .sink { completion in
                    switch completion {
                        case .finished:
                            XCTFail("Cat Fact Publisher shouldn't completed successfully")
                            break
                        case .failure(let error):
                            XCTAssertTrue(true, "Cat Fact Publisher successfully to fail with error: \(error.localizedDescription)")
                            break
                    }
                    expectation.fulfill()
                } receiveValue: { model in
                    XCTFail("This publisher completion shouldn't execute when it's failure")
                    expectation.fulfill()
                }
                .store(in: &cancellables)
            
            wait(for: [expectation], timeout: 1.0)
        }
    }
    
    func testRetrieveCatImage_ReturnFailures() {
        let errorDictionary: [CatServiceError: String] = [.badURL: "Mock cat service retrieving image to fail for bad url error",
                                                     .networkError: "Mock cat service retrieving image to fail for network error",
                                                     .decodingError: "Mock cat service retrieving image to fail for decoding error",
                                                     .generalError: "Mock cat service retrieving image to fail for general error"]
        for (error, description) in errorDictionary {
            (sut as! MockCatService).errorToThrow = error
            
            let expectation = XCTestExpectation(description: description)
            
            sut.fetchCatImage()
                .sink { completion in
                    switch completion {
                        case .finished:
                            XCTFail("Cat Fact Publisher shouldn't completed successfully")
                            break
                        case .failure(let error):
                            XCTAssertTrue(true, "Cat Fact Publisher successfully to fail with error: \(error.localizedDescription)")
                            break
                    }
                    expectation.fulfill()
                } receiveValue: { model in
                    XCTFail("This publisher completion shouldn't execute when it's failure")
                    expectation.fulfill()
                }
                .store(in: &cancellables)
            
            wait(for: [expectation], timeout: 1.0)
        }
    }
    
    func testRetrieveCatImageUrl_ReturnSuccessfulCatImage() {
        let expectation = XCTestExpectation(description: "Mock cat service that returns the expected cat image url")
        
        sut.fetchCatImage()
            .sink { completion in
                switch completion {
                    case .finished:
                        XCTAssertTrue(true, "Cat Fact Publisher completed successfully")
                        break
                    case .failure(let error):
                        XCTFail("Cat Fact Publisher failed with error: \(error.localizedDescription)")
                        break
                }
                
                expectation.fulfill()
            } receiveValue: { models in
                let urlString = models.first?.url
                
                XCTAssertEqual(urlString, "https://google.com/", "The url provided is not the expected url")
                XCTAssertNotNil(URL(string: urlString!), "The provided url is not a valid url")
                
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1.0)
    }
}
