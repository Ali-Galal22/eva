//
//  MainViewModel.swift
//  Eva
//
//  Created by AmrFawaz on 13/10/2021.
//  Copyright © 2021 AmrFawaz. All rights reserved.
//

import Foundation
protocol MainViewModelCoordinator {
}
protocol MainListDelegate: AnyObject {
    func onStateChanged(state: LoadingState)
}


class MainViewModel {
    private let coordinator: MainViewModelCoordinator
    private var service: [Service]?
    private var projects: [Project]?
    private unowned var delegate: MainListDelegate?

    // MARK: - State management

    private var state: LoadingState = .loading {
        didSet {
            delegate?.onStateChanged(state: state)
        }
    }

    // MARK: - Initializer
    
    init(coordinator: MainViewModelCoordinator) {
        self.coordinator = coordinator
    }
    
    func configure(with delegate: MainListDelegate) {
        self.delegate = delegate
        loadData()
    }
    
    func getProject(index: Int) -> Project? {
        return projects?[index]
    }
    
    func getService(index: Int) -> Service? {
        return service?[index]
    }


    private func loadData() {
        state = .loading
        APIClient.getHomeList(parameters: ["action": "index"]) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.service = response.data?.services
                self.projects = response.data?.projects
                self.state = .ready
            case .failure(let error):
                self.state = .error(error: error.localizedDescription)
            }
        }
    }
    
    func getNumberOfSections() -> Int {
        return 2
    }
    
    func getNumberOfRows(section: Int) -> Int {
        switch section {
        case 0:
            return self.projects?.count ?? 0
        case 1:
            return self.service?.count ?? 0
        default:
            return 0
        }
    }
    
}
