//
//  ServicesViewModel.swift
//  Eva
//
//  Created by AmrFawaz on 19/10/2021.
//  Copyright © 2021 AmrFawaz. All rights reserved.
//

import Foundation

protocol ServicesViewModelCoordinator {
    func navigateToInterst(service: Service)
}

protocol ServicesDelegate: AnyObject {
    func onStateChanged(state: LoadingState)
}

class ServicesViewModel {
    private let coordinator: ServicesViewModelCoordinator
    private unowned var delegate: ServicesDelegate?
    private var services: [Service]?
    
    // MARK: - State management
    private var state: LoadingState = .loading {
        didSet {
            delegate?.onStateChanged(state: state)
        }
    }

    // MARK: - Initializer
    
    init(coordinator: ServicesViewModelCoordinator) {
        self.coordinator = coordinator
    }

    func configure(with delegate: ServicesDelegate) {
        self.delegate = delegate
        loadData()
    }

    private func loadData() {
        self.state = .loading
        APIClient.getHomeList(parameters: ["action": "services"]) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.services = response.data?.services
                self.state = .ready(.homeList(queryParameters: [:]))
            case .failure(let error):
                self.state = .error(error: error.localizedDescription)
            }
        }
    }
    
    func getServiceCount() -> Int {
        return services?.count ?? 0
    }
    
    func getService(index: Int) -> Service? {
        return services?[index]
    }

    func navigateToInterst(index: Int) {
        if let service = services?[index] {
            coordinator.navigateToInterst(service: service)
        }
    }
}
