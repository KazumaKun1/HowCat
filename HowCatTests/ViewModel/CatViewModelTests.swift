//
//  CatViewModelTests.swift
//  HowCat
//
//  Created by Arviejhay Alejandro on 10/1/24.
//

import Testing
import Combine
import Foundation

@testable import HowCat

struct CatViewModelTests {
    var sut: CatViewModel
    var mockCatService: CatServiceProtocol
    
    init() {
        let service = MockCatService()
        sut = CatViewModel(catService: service)
        mockCatService = service
    }
    
    @Test("Test CatViewModel with mock cat service to retrieve the cat fact and image")
    func returnCatFactImage() async {
        let subject = sut.navigationTrigger
        var cancellables = Set<AnyCancellable>()

        // The pipeline hops onto DispatchQueue.main (twice), so the sink fires on a
        // later runloop turn, not synchronously within `send()`. XCTest's wait(for:)
        // pumped the runloop for us; Swift Testing's `confirmation` body needs to
        // actually suspend for that hop, so we bridge it with a continuation instead
        // of returning immediately after `send()`.
        await confirmation { confirmation in
            await withCheckedContinuation { continuation in
                subject
                    .sink { route in
                        guard route == .fact else { return }
                        confirmation()
                        continuation.resume()
                    }
                    .store(in: &cancellables)

                sut.screenTappedSubject.send()
            }
        }

        let link = MockData.sampleImageUrl
        #expect(sut.content.fact == "This is a fact", "The fact provided is not the expected fact")
        #expect(sut.content.imageUrl == URL(string: link), "The image url is not the expected url")
        #expect(sut.content.imageUrl.absoluteString == link, "The image url string is not the expected url string")
    }

    @Test("Validate Cat View Model Errors", arguments: [
        CatServiceError.badURL,
        CatServiceError.networkError,
        CatServiceError.decodingError,
        CatServiceError.generalError
    ])
    func returnCatViewModelFailures(error: CatServiceError) async {
        (mockCatService as! MockCatService).errorToThrow = error
        let tempSUT = CatViewModel(catService: mockCatService)
        var cancellables = Set<AnyCancellable>()

        tempSUT.navigationTrigger
            .sink { route in
                if route == .fact {
                    Issue.record("Should not navigate to .fact on error")
                }
            }
            .store(in: &cancellables)

        await confirmation { confirmation in
            await withCheckedContinuation { continuation in
                tempSUT.alertTrigger
                    .sink { alertConfig in
                        #expect(alertConfig.title == "Cat API Down", "The alert title is not the expected title")
                        #expect(alertConfig.message == "Please try again later.", "The alert message is not the expected message")
                        confirmation()
                        continuation.resume()
                    }
                    .store(in: &cancellables)

                tempSUT.screenTappedSubject.send()
            }
        }
    }
}
