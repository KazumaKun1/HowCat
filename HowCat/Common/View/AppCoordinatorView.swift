//
//  AppCoordinatorView.swift
//  HowCat
//
//  Created by Arviejhay Alejandro on 7/25/26.
//

import SwiftUI

struct AppCoordinatorView: View {
    @State var coordinator: AppCoordinator
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            coordinator.build(route: .start)
                .navigationDestination(for: AppRoute.self) { route in
                    coordinator.build(route: route)
                }
        }
        .onReceive(coordinator.viewModel.dedupedNavigationTrigger) { route in
            coordinator.navigate(to: route)
        }
        .onReceive(coordinator.viewModel.alertTrigger) { config in
            coordinator.presentAlert(config)
        }
        .alert(item: $coordinator.activeAlert) { config in
            Alert(
                title: Text(config.title),
                message: Text(config.message),
                dismissButton: .default(
                    Text(config.primaryButtonText)
                ) {
                    config.action?()
                }
            )
        }
    }
}
