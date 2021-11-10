//
//  StartUpCoordinator.swift
//  MYWE
//
//  Created by AmrFawaz on 04/10/2021.
//  Copyright © 2021 Segmatek. All rights reserved.
//

import UIKit

class StartUpCoordinator {
    private(set) var window: UIWindow?

    func start() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        window?.makeKeyAndVisible()
        window?.rootViewController = rootNavigationController

    }
    
    private lazy var rootNavigationController: UINavigationController = {
        let viewModel = StartUpViewModel(coordinator: self)
        let viewController = StartUpViewController(viewModel: viewModel)
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.navigationBar.isHidden = true
        return navigationController
    }()

}
extension StartUpCoordinator: StartUpViewModelCoordinator {
    func navigateToHome() {
        let homeCoordinator = HomeCoordinator(navigationCoontroller: rootNavigationController)
        homeCoordinator.start()
    }
}
