//
//  MenuViewModel.swift
//  Eva
//
//  Created by AmrFawaz on 29/10/2021.
//  Copyright © 2021 AmrFawaz. All rights reserved.
//

import Foundation
protocol MenuDelegate: AnyObject {
}

protocol MenuViewModelCoordinator {
    func navigateToOurPartners()
}

enum MenuItems: String {
    case mainView = "الرئيسية"
    case projects = "المشاريع"
    case services = "خدماتنا"
    case aboutUs = "من نحن"
    case ourPartners = "شركائنا"
    case contactUs = "اتصل بنا"
}

class MenuViewModel {
    private let coordinator: MenuViewModelCoordinator
    private unowned var delegate: MenuDelegate?
    private let menuItems: [MenuItems] = [.mainView, .projects, .services, .aboutUs, .ourPartners, .contactUs]

    // MARK: - Initializer
    
    init(coordinator: MenuViewModelCoordinator) {
        self.coordinator = coordinator
    }

    func configure(with delegate: MenuDelegate) {
        self.delegate = delegate
        loadData()
    }

    private func loadData() {
    }
    
    func getMenuItems() -> [MenuItems] {
        return menuItems
    }
    
    
    func navigateToOurPartners() {
        coordinator.navigateToOurPartners()
    }


}
