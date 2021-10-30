//
//  PartnersViewController.swift
//  Eva
//
//  Created by AmrFawaz on 29/10/2021.
//  Copyright © 2021 AmrFawaz. All rights reserved.
//

import UIKit

class PartnersViewController: UIViewController {
    // MARK: Outlets:
    @IBOutlet weak var tableView: UITableView!
    
    private let viewModel: OurPartnersViewModel
    private weak var activityIndicator: UIActivityIndicatorView!

    // MARK: - Initializers
    init(viewModel: OurPartnersViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "PartnersViewController", bundle: nil)
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
        tableView.register(UINib(nibName: Constants.CellsIdentefires.PartnerCell, bundle: nil), forCellReuseIdentifier: Constants.CellsIdentefires.PartnerCell)
    }
    
    // MARK: - Actions
    @IBAction func buttonBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}


extension PartnersViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.partnersNumber()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let partnerCell = tableView.dequeueReusableCell(withIdentifier: Constants.CellsIdentefires.PartnerCell) as? PartnerCell
        let partner = viewModel.getPartnerCell(index: indexPath.row)
        partnerCell?.configuerCell(imageUrl: partner.partnerImageUrl, partnerName: partner.partnerName)
        return partnerCell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 106
    }
}


extension PartnersViewController: PartnersDelegate {
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
