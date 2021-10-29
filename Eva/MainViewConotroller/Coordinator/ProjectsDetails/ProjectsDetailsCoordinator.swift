//
//  ProjectsDetailsCoordinator.swift
//  Eva
//
//  Created by AmrFawaz on 23/10/2021.
//  Copyright © 2021 AmrFawaz. All rights reserved.
//

import UIKit

class ProjectsDetailsCoordinator {
    let navigationController: UINavigationController
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

//    private lazy var sendRequestViewController: ServicesViewController = {
//        let servicesViewModel = ServicesViewModel(coordinator: servicesCoordinator)
//        let servicesViewController = ServicesViewController(viewModel: servicesViewModel)
//        servicesViewController.view.backgroundColor = #colorLiteral(red: 0.1764705882, green: 0.2901960784, blue: 0.5607843137, alpha: 1)
//
//        servicesViewController.title = "الخدمات"
//        return servicesViewController
//    }()

    
}
extension ProjectsDetailsCoordinator: ProjectsDetailsViewModelCoordinator {
    func navigateToProjectInterst(project: Project) {
        let sendRequestCoordinator = SendRequestCoordinator(navigationController: self.navigationController)
        let sendRequestViewModel = SendRequestViewModel(coordinator: sendRequestCoordinator, service: nil, project: project, requestType: .project)
        let sendRequestViewController = SendRequestViewController(viewModel: sendRequestViewModel)
        sendRequestViewController.modalPresentationStyle = .fullScreen
        navigationController.presentedViewController?.present(sendRequestViewController, animated: true, completion: nil)
    }
}
