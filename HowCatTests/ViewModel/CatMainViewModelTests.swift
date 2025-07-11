//
//  CatMainViewModelTests.swift
//  HowCat
//
//  Created by Arviejhay Alejandro on 10/1/24.
//

import XCTest
import Combine

@testable import HowCat

@MainActor
class CatMainViewModelTests: XCTestCase {
    var sut: CatMainViewModel!
    var mockCatService: CatServiceProtocol!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        mockCatService = MockCatService()
        sut = CatMainViewModel(catService: mockCatService)
        cancellables = Set<AnyCancellable>()
    }

    override func tearDown() {
        sut = nil
        mockCatService = nil
        cancellables = nil
        super.tearDown()
    }

    func testViewModel_ReturnCatFactImage() {
        let expectation = XCTestExpectation(description: "Test CatMainViewModel with mock cat service to retrieve the cat fact and image")

        sut.fetchCatContent()

        sut.$state
            .dropFirst()
            .sink { state in
                switch state {
                case .factScreen(let content):
                    let link = MockData.sampleImageUrl
                    XCTAssertEqual(content.fact, "This is a fact", "The fact provided is not the expected fact")
                    XCTAssertEqual(content.imageUrl, URL(string: link), "The image url is not the expected url")
                    XCTAssertEqual(content.imageUrl.absoluteString, link, "The image url string is not the expected url string")
                    expectation.fulfill()
                default:
                    break
                }
            }
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1.0)
    }

    func testViewModel_ReturnFailures() {
        let errorDictionary: [CatServiceError: String] = [
            .badURL: "Test CatMainViewModel with mock cat service set to bad url error, should set errorMessage and not update state to factScreen",
            .networkError: "Test CatMainViewModel with mock cat service set to network error, should set errorMessage and not update state to factScreen",
            .decodingError: "Test CatMainViewModel with mock cat service set to decoding error, should set errorMessage and not update state to factScreen",
            .generalError: "Test CatMainViewModel with mock cat service set to general error, should set errorMessage and not update state to factScreen"
        ]

        for (error, description) in errorDictionary {
            let expectation = XCTestExpectation(description: description)

            (mockCatService as! MockCatService).errorToThrow = error
            let tempSUT = CatMainViewModel(catService: mockCatService)

            tempSUT.fetchCatContent()

            // Observe errorMessage and state
            var cancellables = Set<AnyCancellable>()
            tempSUT.$errorMessage
                .dropFirst()
                .sink { errorMessage in
                    if let errorMessage = errorMessage, !errorMessage.isEmpty {
                        // Ensure state is not .factScreen
                        if case .factScreen = tempSUT.state {
                            XCTFail("State should not be .factScreen on error")
                        }
                        expectation.fulfill()
                    }
                }
                .store(in: &cancellables)

            wait(for: [expectation], timeout: 2.0)
        }
    }
}
