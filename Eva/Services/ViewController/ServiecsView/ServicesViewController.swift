//
//  ServicesViewController.swift
//  Eva
//
//  Created by AmrFawaz on 19/10/2021.
//  Copyright © 2021 AmrFawaz. All rights reserved.
//

import UIKit

class ServicesViewController: UIViewController {
    
    // MARK: Outlets:
    @IBOutlet weak var tableView: UITableView!
    
    private let viewModel: ServicesViewModel
    private weak var activityIndicator: UIActivityIndicatorView!

    // MARK: - Initializers
    init(viewModel: ServicesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "ServicesViewController", bundle: nil)
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
        tableView.register(UINib(nibName: Constants.CellsIdentefires.ServiceCell, bundle: nil), forCellReuseIdentifier: Constants.CellsIdentefires.ServiceCell)
    }

}

extension ServicesViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getServiceCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let serviceCell = tableView.dequeueReusableCell(withIdentifier: Constants.CellsIdentefires.ServiceCell) as? ServiceCell
        serviceCell?.cellIndex = indexPath.row
        serviceCell?.configureServiceCell(with: self, and: viewModel.getService(index: indexPath.row))
        return serviceCell!
    }
    
}

extension ServicesViewController: ServicesDelegate {
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
extension ServicesViewController: ServiceCellDelegate {
    func didClickInteret(for cellIndex: Int) {
        viewModel.navigateToInterst(index: cellIndex)
    }
    
    func didClickReadMore(for cellIndex: Int) {
        viewModel.navigateToServiceDetails(index: cellIndex)
    }
 
}
