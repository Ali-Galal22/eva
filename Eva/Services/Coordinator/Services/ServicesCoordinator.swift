//
//  ServicesCoordinator.swift
//  Eva
//
//  Created by AmrFawaz on 19/10/2021.
//  Copyright © 2021 AmrFawaz. All rights reserved.
//

import Foundation
import UIKit

class ServicesCoordinator {
    
    private var navigationController: UINavigationController?
    
    func setNavigationBar(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    

}
extension ServicesCoordinator: ServicesViewModelCoordinator {
    
    func navigateToInterst(service: Service) {
        let sendRequestCoordinator = SendRequestCoordinator(navigationController: self.navigationController!)
        let sendRequestViewModel = SendRequestViewModel(coordinator: sendRequestCoordinator, service: service)
        let sendRequestViewController = SendRequestViewController(viewModel: sendRequestViewModel)
        sendRequestViewController.modalPresentationStyle = .fullScreen
        navigationController?.present(sendRequestViewController, animated: true, completion: nil)
    }
    
    
    func navigateToServiceDetails(service: Service) {
        let serviceDetailsViewModel = ServiceDetailsViewModel(service: service)
        let serviceDetailsViewController = ServiceDetailsViewController(viewModel: serviceDetailsViewModel)
        serviceDetailsViewController.modalPresentationStyle = .fullScreen
        navigationController?.present(serviceDetailsViewController, animated: true, completion: nil)

    }


}
