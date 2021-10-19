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

    init(navigationCoontroller: UINavigationController) {
        self.navigationCoontroller = navigationCoontroller
        self.navigationCoontroller.navigationBar.isHidden = false
        self.navigationCoontroller.navigationBar.backgroundColor = #colorLiteral(red: 0.1764705882, green: 0.2901960784, blue: 0.5607843137, alpha: 1)
        self.navigationCoontroller.navigationBar.tintColor = .white
        self.navigationCoontroller.navigationBar.isTranslucent = true
        self.navigationCoontroller.navigationBar.setBackgroundImage(UIImage(), for: .default)
    }
    
    func start() {
        self.navigationCoontroller.pushViewController(tabBarController, animated: false)
    }

    
    private lazy var tabBarController: UITabBarController = {
        let viewModel = HomeViewModel(coordinator: self)
        let homeViewController = HomeTabBarViewController(viewModel: viewModel)
        homeViewController.tabBar.backgroundColor = .white


        // Main Tab
        let mainNavigationController = UINavigationController(rootViewController: mainViewController)
        mainNavigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        mainNavigationController.navigationBar.titleTextAttributes = textAttributes


        
        let filter = UIBarButtonItem(image: UIImage(named: "filter"), style: .plain, target: self, action: #selector(navigateToFilter))
        mainNavigationController.navigationBar.topItem?.rightBarButtonItem = filter

        
        let viewController2 = UIViewController()
        viewController2.view.backgroundColor = .green
        viewController2.title = "المشاريع"

        let viewController3 = UIViewController()
        viewController3.view.backgroundColor = .blue
        let viewController4 = UIViewController()
        viewController4.view.backgroundColor = .yellow
        
        homeViewController.viewControllers = [mainNavigationController, viewController2, viewController3, viewController4]
        
        mainNavigationController.tabBarItem = homeViewController.item1
        viewController2.tabBarItem = homeViewController.item2
        viewController3.tabBarItem = homeViewController.item3
        viewController4.tabBarItem = homeViewController.item4
        return homeViewController
    }()
    
    
    private lazy var mainViewController: MainViewController = {
//        let mainCoordinator = MainCoordinator()
//        let mainViewModel = MainViewModel(coordinator: mainCoordinator)
        let mainViewController = MainViewController(viewModel: mainViewModel)
        mainViewController.view.backgroundColor = #colorLiteral(red: 0.1764705882, green: 0.2901960784, blue: 0.5607843137, alpha: 1)
        mainViewController.title = "الرئيسية"
        return mainViewController
    }()
    

    private lazy var filterViewController: FilterViewController = {
        let filterViewController = FilterViewController(viewModel: mainViewModel)
        filterViewController.modalPresentationStyle = .fullScreen

        return filterViewController
    }()
    
    
    @objc func navigateToFilter() {
        mainViewController.present(filterViewController, animated: true, completion: nil)
    }


}
extension HomeCoordinator: HomeViewModelCoordinator {
}
