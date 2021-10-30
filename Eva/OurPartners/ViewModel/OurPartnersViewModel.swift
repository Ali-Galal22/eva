//
//  OurPartnersViewModel.swift
//  Eva
//
//  Created by AmrFawaz on 29/10/2021.
//  Copyright © 2021 AmrFawaz. All rights reserved.
//

import Foundation

protocol PartnersDelegate: AnyObject {
    func onStateChanged(state: LoadingState)
}

protocol PartnersViewModelCoordinator {
}


class OurPartnersViewModel {
    private let coordinator: PartnersViewModelCoordinator
    private unowned var delegate: PartnersDelegate?
    private var partners: [Partner]?
    
    // MARK: - State management
    private var state: LoadingState = .loading {
        didSet {
            delegate?.onStateChanged(state: state)
        }
    }

    // MARK: - Initializer
    
    init(coordinator: PartnersViewModelCoordinator) {
        self.coordinator = coordinator
    }

    func configure(with delegate: PartnersDelegate) {
        self.delegate = delegate
        loadData()
    }

    private func loadData() {
        self.state = .loading
        APIClient.getGetOurPartners(parameters: ["action": "partiners"]) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.partners = response.data?.partiners
                self.state = .ready()
            case .failure(let error):
                self.state = .error(error: error.localizedDescription)
            }
        }
    }
    
    func partnersNumber() -> Int {
        return partners?.count ?? 0
    }
    
    func getPartnerCell(index: Int) -> (partnerImageUrl: String, partnerName: String) {
        let partner = partners?[index]
        return (partner?.image ?? "", partner?.title ?? "")
    }

}
