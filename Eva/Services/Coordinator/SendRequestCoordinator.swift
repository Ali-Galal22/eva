//
//  SendRequestCoordinator.swift
//  Eva
//
//  Created by AmrFawaz on 21/10/2021.
//  Copyright © 2021 AmrFawaz. All rights reserved.
//

import Foundation
import UIKit

class SendRequestCoordinator {
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}

extension SendRequestCoordinator: SendRequestViewModelCoordinator {
    func showSuccessView() {
        let successViewController = SuccessViewController()
        successViewController.modalPresentationStyle = .overFullScreen

        self.navigationController.present(successViewController, animated: true, completion: nil)
    }
    
    
}
