//
//  ServiceDetailsCoordinator.swift
//  Eva
//
//  Created by AmrFawaz on 22/10/2021.
//  Copyright © 2021 AmrFawaz. All rights reserved.
//

import Foundation
import UIKit

class ServiceDetailsCoordinator {
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

}

extension ServiceDetailsCoordinator: ServiceDetailsViewModelCoordinator {
    
}
