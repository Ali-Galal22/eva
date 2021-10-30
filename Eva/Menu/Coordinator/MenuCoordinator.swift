//
//  MenuCoordinator.swift
//  Eva
//
//  Created by AmrFawaz on 29/10/2021.
//  Copyright © 2021 AmrFawaz. All rights reserved.
//

import Foundation
import UIKit

class MenuCoordinator {
    private var navigationController: UINavigationController?
    
    func setNavigationBar(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

}
extension MenuCoordinator: MenuViewModelCoordinator {
    func navigateToOurPartners() {
        let partersCoordinator = PartnersCoordinator(navigationController: self.navigationController!)
        let partnersViewModel = OurPartnersViewModel(coordinator: partersCoordinator)
        let partnersViewController = PartnersViewController(viewModel: partnersViewModel)
        partnersViewController.modalPresentationStyle = .fullScreen
        navigationController?.present(partnersViewController, animated: true, completion: nil)
    }
}

