//
//  MainCoordinator.swift
//  Eva
//
//  Created by AmrFawaz on 13/10/2021.
//  Copyright © 2021 AmrFawaz. All rights reserved.
//

import Foundation
import UIKit

class MainCoordinator {

    private var navigationController: UINavigationController?
    
    func setNavigationController(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    private lazy var projectDetailsCoordinator: ProjectsDetailsCoordinator = {
        let projectDetailsCoordinator = ProjectsDetailsCoordinator(navigationController: navigationController!)
        return projectDetailsCoordinator
    }()
    
//    private lazy var projectDetailsViewModel: ProjectsDetailsViewModel = {
//        let projectDetailsViewModel = ProjectsDetailsViewModel(coordinator: self.projectDetailsCoordinator)
//        return projectDetailsViewModel
//    }()


    
//    private lazy var projectDetailsViewController: ProjectsDetailsViewController = {
//        let projectDetailsViewConotroller = ProjectsDetailsViewController(viewModel: projectDetailsViewModel)
//        projectDetailsViewConotroller.view.backgroundColor = #colorLiteral(red: 0.1764705882, green: 0.2901960784, blue: 0.5607843137, alpha: 1)
//        return projectDetailsViewConotroller
//    }()

    

}
extension MainCoordinator: MainViewModelCoordinator {
    func navigateToProjectDetails(projectId: Int) {
        let projectDetailsViewModel = ProjectsDetailsViewModel(coordinator: self.projectDetailsCoordinator, projectId: projectId)

        let projectDetailsViewConotroller = ProjectsDetailsViewController(viewModel: projectDetailsViewModel)
        projectDetailsViewConotroller.view.backgroundColor = #colorLiteral(red: 0.1764705882, green: 0.2901960784, blue: 0.5607843137, alpha: 1)

        let navigationController = UINavigationController(rootViewController: projectDetailsViewConotroller)
        navigationController.modalPresentationStyle = .fullScreen
        
        self.navigationController?.present(navigationController, animated: true, completion: nil)
    }
    
    func navigateToServiceDetails(service: Service) {
        let serviceDetailsViewModel = ServiceDetailsViewModel(service: service)
        let serviceDetailsViewController = ServiceDetailsViewController(viewModel: serviceDetailsViewModel)
        serviceDetailsViewController.modalPresentationStyle = .fullScreen
        navigationController?.present(serviceDetailsViewController, animated: true, completion: nil)

    }
    
}
