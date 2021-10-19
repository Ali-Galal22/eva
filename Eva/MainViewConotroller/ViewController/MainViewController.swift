//
//  MainViewController.swift
//  Eva
//
//  Created by AmrFawaz on 13/10/2021.
//  Copyright © 2021 AmrFawaz. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    private weak var activityIndicator: UIActivityIndicatorView!
    private let viewModel: MainViewModel

    // MARK: - Initializers

    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "MainViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator = view.addLoadingIndicator()
        viewModel.configure(with: self, view: .home)
        registerCells()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    private func registerCells() {
        tableView.register(UINib(nibName: "\(HomeCell.self)", bundle: nil), forCellReuseIdentifier: "\(HomeCell.self)")
    }
    
}


extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.getNumberOfSections()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfRows(section: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let homeCell = tableView.dequeueReusableCell(withIdentifier: "\(HomeCell.self)") as? HomeCell
        switch indexPath.section {
        case 0:
            homeCell?.configureProjectCell(with: self, and: viewModel.getProject(index: indexPath.row))
        case 1:
            homeCell?.configureServiceCell(with: self, and: viewModel.getService(index: indexPath.row))
        default:
            break
        }
        return homeCell!
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 1 {
            return 16
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 16))
        footerView.backgroundColor = #colorLiteral(red: 0.9215686275, green: 0.9333333333, blue: 0.9490196078, alpha: 1)
        return footerView
    }
}


extension MainViewController: MainListDelegate {
    func onStateChanged(state: LoadingState) {
        switch state {
        case .loading:
            activityIndicator.startAnimating()
        case .ready:
            activityIndicator.stopAnimating()
            tableView.reloadData()
        case .error:
            activityIndicator.stopAnimating()
            // TODO: handle error case by showing an error view with a retry button
            break
        }
    }

    
}

extension MainViewController: HomeCellDelegate {
    func didClickDetails() {
        
    }
}
