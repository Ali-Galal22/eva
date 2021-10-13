//
//  StartUpViewModel.swift
//  MYWE
//
//  Created by AmrFawaz on 04/10/2021.
//  Copyright © 2021 Segmatek. All rights reserved.
//

import Foundation
protocol StartUpViewModelCoordinator {
    func navigateToHome()
}

class StartUpViewModel {
    private let coordinator: StartUpViewModelCoordinator

    // MARK: - Initializer
    
    init(coordinator: StartUpViewModelCoordinator) {
        self.coordinator = coordinator
    }
    
    func navigateToHome() {
        self.coordinator.navigateToHome()
    }
}
