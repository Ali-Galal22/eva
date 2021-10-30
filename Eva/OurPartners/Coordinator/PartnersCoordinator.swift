//
//  PartnersCoordinator.swift
//  Eva
//
//  Created by AmrFawaz on 29/10/2021.
//  Copyright © 2021 AmrFawaz. All rights reserved.
//

import Foundation
import UIKit

class PartnersCoordinator {
    private var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

}
extension PartnersCoordinator: PartnersViewModelCoordinator {
}
