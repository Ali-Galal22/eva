//
//  MenuViewController.swift
//  Eva
//
//  Created by AmrFawaz on 29/10/2021.
//  Copyright © 2021 AmrFawaz. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    // MARK: Outlets:

    @IBOutlet weak var tableview: UITableView!
    
    private let viewModel: MenuViewModel
    private weak var activityIndicator: UIActivityIndicatorView!

    // MARK: - Initializers
    init(viewModel: MenuViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "MenuViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator = view.addLoadingIndicator()
        viewModel.configure(with: self)
        registerCells()

    }

    private func registerCells() {
        tableview.register(UINib(nibName: Constants.CellsIdentefires.MenuItemCell, bundle: nil), forCellReuseIdentifier: Constants.CellsIdentefires.MenuItemCell)
    }

}

extension MenuViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getMenuItems().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let menuCell = tableview.dequeueReusableCell(withIdentifier: Constants.CellsIdentefires.MenuItemCell) as? MenuItemCell
        menuCell?.labelItemTitle.text = viewModel.getMenuItems()[indexPath.row].rawValue
        switch viewModel.getMenuItems()[indexPath.row] {
        case .mainView:
            menuCell?.imageViewItem.image = #imageLiteral(resourceName: "menu-main")
        case .projects:
            menuCell?.imageViewItem.image = #imageLiteral(resourceName: "menu-projects")
        case .services:
            menuCell?.imageViewItem.image = #imageLiteral(resourceName: "menu-service")
        case .aboutUs:
            menuCell?.imageViewItem.image = #imageLiteral(resourceName: "menu-about-us")
        case .ourPartners:
            menuCell?.imageViewItem.image = #imageLiteral(resourceName: "menu-partners")
        case .contactUs:
            menuCell?.imageViewItem.image = #imageLiteral(resourceName: "menu-contact-us")
        }
        return menuCell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch viewModel.getMenuItems()[indexPath.row] {
        case .mainView:
            self.tabBarController?.navigationController?.popViewController(animated: true)
        case .projects:
            self.tabBarController?.selectedIndex = 0
        case .services:
            self.tabBarController?.selectedIndex = 1
        case .ourPartners:
            self.viewModel.navigateToOurPartners()
        case .contactUs:
            viewModel.contactUs()
        case .aboutUs:
            viewModel.aboutUs()
        }
    }
}
extension MenuViewController: MenuDelegate {
    func onStateChanged(state: LoadingState) {
        switch state {
        case .loading:
            activityIndicator.startAnimating()
        case .ready:
            activityIndicator.stopAnimating()
            tableview.reloadData()
        case .error:
            activityIndicator.stopAnimating()
            // TODO: handle error case by showing an error view with a retry button
            break
        }
    }
    

}
