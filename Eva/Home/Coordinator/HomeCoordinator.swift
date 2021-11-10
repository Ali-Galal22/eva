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
    private lazy var mainCoordinator = MainCoordinator()
    private lazy var mainViewModel = MainViewModel(coordinator: mainCoordinator)

    let servicesCoordinator = ServicesCoordinator()
    let menuCoordinator = MenuCoordinator()
    
    init(navigationCoontroller: UINavigationController) {
        self.navigationCoontroller = navigationCoontroller
        self.navigationCoontroller.navigationBar.isHidden = true
//        self.navigationCoontroller.navigationBar.backgroundColor = #colorLiteral(red: 0.1764705882, green: 0.2901960784, blue: 0.5607843137, alpha: 1)
//        self.navigationCoontroller.navigationBar.tintColor = .white
//        self.navigationCoontroller.navigationBar.isTranslucent = true
//        self.navigationCoontroller.navigationBar.setBackgroundImage(UIImage(), for: .default)
    }
    
    func start() {
        self.navigationCoontroller.pushViewController(tabBarController, animated: false)
    }

    
    private lazy var tabBarController: UITabBarController = {

        let viewModel = HomeViewModel(coordinator: self)
        let homeViewController = HomeTabBarViewController(viewModel: viewModel)
        homeViewController.tabBar.backgroundColor = .white
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]


        // Main Tab
        let mainNavigationController = UINavigationController(rootViewController: mainViewController)
        mainNavigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
        mainNavigationController.navigationBar.titleTextAttributes = textAttributes
        mainNavigationController.navigationBar.tintColor = .white
        let filter = UIBarButtonItem(image: UIImage(named: "filter"), style: .plain, target: self, action: #selector(navigateToFilter))
        mainNavigationController.navigationBar.topItem?.rightBarButtonItem = filter
        mainCoordinator.setNavigationController(navigationController: mainNavigationController)
        

        // Servies Tab
        let servicesRootViewController = servicesViewController
        let servicesNavigationController = UINavigationController(rootViewController: servicesViewController)
        servicesNavigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
        servicesNavigationController.navigationBar.titleTextAttributes = textAttributes
        servicesNavigationController.navigationBar.tintColor = .white
        servicesCoordinator.setNavigationBar(navigationController: servicesNavigationController)
        
        
        // Menu Tab
        let menuRootViewController = menuViewController
        let menuNavigationController = UINavigationController(rootViewController: menuViewController)
        menuNavigationController.navigationBar.isHidden = true
        servicesNavigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
        menuCoordinator.setNavigationBar(navigationController: menuNavigationController)

        
        homeViewController.viewControllers = [mainNavigationController, servicesNavigationController, menuNavigationController]
        mainNavigationController.tabBarItem = homeViewController.item1
        servicesNavigationController.tabBarItem = homeViewController.item2
        menuNavigationController.tabBarItem = homeViewController.item3
        return homeViewController
    }()
    
    
    private lazy var mainViewController: MainViewController = {
        let mainViewController = MainViewController(viewModel: mainViewModel)
        mainViewController.view.backgroundColor = #colorLiteral(red: 0.1764705882, green: 0.2901960784, blue: 0.5607843137, alpha: 1)
        mainViewController.title = "المشاريع"
        return mainViewController
    }()
    
    private lazy var servicesViewController: ServicesViewController = {
        let servicesViewModel = ServicesViewModel(coordinator: servicesCoordinator)
        let servicesViewController = ServicesViewController(viewModel: servicesViewModel)
        servicesViewController.view.backgroundColor = #colorLiteral(red: 0.1764705882, green: 0.2901960784, blue: 0.5607843137, alpha: 1)

        servicesViewController.title = "الخدمات"
        return servicesViewController
    }()
    
    private lazy var menuViewController: MenuViewController = {
        let menuViewModel = MenuViewModel(coordinator: menuCoordinator)
        let menuViewController = MenuViewController(viewModel: menuViewModel)
        return menuViewController
    }()


    private lazy var filterViewController: FilterViewController = {
        let filterViewController = FilterViewController(viewModel: mainViewModel)
        filterViewController.modalPresentationStyle = .fullScreen

        return filterViewController
    }()
    
    
    @objc func navigateToFilter() {
        mainViewController.present(filterViewController, animated: true, completion: nil)
    }
    
    @objc func back() {
        navigationCoontroller.popViewController(animated: true)
    }


}
extension HomeCoordinator: HomeViewModelCoordinator {
}
