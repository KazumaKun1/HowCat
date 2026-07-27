//
//  AppCoordinator.swift
//  HowCat
//
//  Created by Arviejhay Alejandro on 7/24/26.
//

import SwiftUI

struct AlertConfig: Identifiable {
    var id = UUID()
    let title: String
    let message: String
    let primaryButtonText: String
    let action: (() -> Void)?
}

enum AppRoute: Hashable {
    case start
    case fact
}

@Observable
class AppCoordinator {
    var path = NavigationPath()
    
    var activeAlert: AlertConfig?
    
    @ObservationIgnored
    lazy var viewModel: CatViewModel = {
        CatViewModel(catService: CatService())
    }()
    
    func presentAlert(_ alert: AlertConfig) {
        self.activeAlert = alert
    }
    
    @ViewBuilder
    func build(route: AppRoute) -> some View {
        switch route {
        case .start:
            CatIntroView(viewModel: viewModel)
        case .fact:
            CatFactView(viewModel: viewModel)
        }
    }
}

// MARK: - Navigation Methods
extension AppCoordinator {
    func navigate(to route: AppRoute) { path.append(route) }
    func goBack() { if !path.isEmpty { path.removeLast() } }
}
