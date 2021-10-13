//
//  HomeCoordinator.swift
//  Eva
//
//  Created by AmrFawaz on 12/10/2021.
//  Copyright © 2021 AmrFawaz. All rights reserved.
//

import UIKit

class HomeCoordinator {

    let navigationCoontroller: UINavigationController
    
    init(navigationCoontroller: UINavigationController) {
        self.navigationCoontroller = navigationCoontroller
    }
    
    func start() {
        self.navigationCoontroller.pushViewController(tabBarController, animated: false)
    }
    
    
    private lazy var tabBarController: UITabBarController = {
        let viewModel = HomeViewModel(coordinator: self)
        let homeViewController = HomeTabBarViewController(viewModel: viewModel)
        
        let mainCoordinator = MainCoordinator()
        let mainViewModel = MainViewModel(coordinator: mainCoordinator)
        let mainViewController = MainViewController(viewModel: mainViewModel)
        
        
        let viewController2 = UIViewController()
        viewController2.view.backgroundColor = .green
        let viewController3 = UIViewController()
        viewController3.view.backgroundColor = .blue
        let viewController4 = UIViewController()
        viewController4.view.backgroundColor = .yellow
        
        homeViewController.viewControllers = [mainViewController, viewController2, viewController3, viewController4]
        
        mainViewController.tabBarItem = homeViewController.item1
        viewController2.tabBarItem = homeViewController.item2
        viewController3.tabBarItem = homeViewController.item3
        viewController4.tabBarItem = homeViewController.item4
        return homeViewController
    }()

}
extension HomeCoordinator: HomeViewModelCoordinator {
    
    
}
