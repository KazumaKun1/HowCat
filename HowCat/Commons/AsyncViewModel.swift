//
//  AsyncViewModel.swift
//  HowCat
//
//  Created by Arviejhay Alejandro on 7/11/25.
//

import Combine

protocol AsyncViewModelProtocol: ObservableObject {
    var isLoading: Bool { get set }
    var errorMessage: String? { get set }
    func cancelSubscriptions()
}

class AsyncViewModel: ObservableObject, AsyncViewModelProtocol {
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    var cancellables = Set<AnyCancellable>()

    func cancelSubscriptions() {
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
    }
}
