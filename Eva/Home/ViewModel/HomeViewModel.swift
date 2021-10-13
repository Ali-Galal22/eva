//
//  HomeViewModel.swift
//  Eva
//
//  Created by AmrFawaz on 12/10/2021.
//  Copyright © 2021 AmrFawaz. All rights reserved.
//

import Foundation

protocol HomeViewModelCoordinator {
    // TODO: - handle StartUp navigations
}

class HomeViewModel {
    private let coordinator: HomeViewModelCoordinator

    // MARK: - Initializer
    
    init(coordinator: HomeViewModelCoordinator) {
        self.coordinator = coordinator
    }
}
