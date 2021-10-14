//
//  HomeTabBarViewController.swift
//  Eva
//
//  Created by AmrFawaz on 12/10/2021.
//  Copyright © 2021 AmrFawaz. All rights reserved.
//

import UIKit

class HomeTabBarViewController: UITabBarController, UITabBarControllerDelegate {

    // MARK: - Properties
    var item1: UITabBarItem?
    var item2: UITabBarItem?
    var item3: UITabBarItem?
    var item4: UITabBarItem?

    private let viewModel: HomeViewModel

    // MARK: - Initializers

    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "HomeTabBarViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = .black
        delegate = self
        self.tabBar.barTintColor = UIColor.white
        
        
        item1 = UITabBarItem(title: "الرئيسية", image: #imageLiteral(resourceName: "tabbar-home-icon"), selectedImage: #imageLiteral(resourceName: "tabbar-home-icon"))
        item2 = UITabBarItem(title: "المشاريع", image: #imageLiteral(resourceName: "tabbat-projects-icon"), selectedImage: #imageLiteral(resourceName: "tabbat-projects-icon"))
        item3 = UITabBarItem(title: "الخدمات", image: #imageLiteral(resourceName: "tabbat-services-icon"), selectedImage: #imageLiteral(resourceName: "tabbat-services-icon"))
        item4 = UITabBarItem(title: "القائمة", image: #imageLiteral(resourceName: "tabbar-menu-icon"), selectedImage: #imageLiteral(resourceName: "tabbar-menu-icon"))

    }

}
