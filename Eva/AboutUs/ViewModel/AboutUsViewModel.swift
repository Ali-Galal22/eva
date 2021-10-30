//
//  AboutUsViewModel.swift
//  Eva
//
//  Created by AmrFawaz on 30/10/2021.
//  Copyright © 2021 AmrFawaz. All rights reserved.
//

import Foundation
protocol AboutUsDelegate: AnyObject {
    func onStateChanged(state: LoadingState)
}


enum AboutUsItems {
    case aboutUs
    case values(opened: Bool = false)
    case message(opened: Bool = false)
    case goals(opened: Bool = false)
}

class AboutUsViewModel {
    private unowned var delegate: AboutUsDelegate?
    private var valuesCell: AboutUsItems = .values(opened: false)
    private var messageCell: AboutUsItems = .message(opened: false)
    private var goalsCell: AboutUsItems = .goals(opened: false)

    private var aboutUsItems: [AboutUsItems] = []
    private var aboutUs: AboutUs?
    
    // MARK: - State management
    private var state: LoadingState = .loading {
        didSet {
            delegate?.onStateChanged(state: state)
        }
    }

    
    func configure(with delegate: AboutUsDelegate) {
        self.delegate = delegate
        self.aboutUsItems = [.aboutUs, valuesCell, messageCell, goalsCell]
        loadData()
    }

    private func loadData() {
        self.state = .loading
        APIClient.getAboutUs(parameters: ["action": "about"]) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.aboutUs = response.data?.page
                self.state = .ready()
            case .failure(let error):
                self.state = .error(error: error.localizedDescription)
            }
        }

    }
    
    func getAboutUsItems() -> [AboutUsItems] {
        return [.aboutUs, valuesCell, messageCell, goalsCell]
    }

    func getAboutUsItemsCount() -> Int {
        return aboutUsItems.count
    }
    
    func getAboutUsMainCell() -> (title: String, content: String) {
        return (title: "عن ايفا", content: aboutUs?.content ?? "")
    }
    
    func setValuesCellOpend(isOpen: Bool) {
        valuesCell = .values(opened: isOpen)
    }

    func setMessageCellOpend(isOpen: Bool) {
        messageCell = .message(opened: isOpen)
    }
    
    func setGoalsCellOpend(isOpen: Bool) {
        goalsCell = .goals(opened: isOpen)
    }


    func getValuesCell() -> (title: String, content: String) {
        return (title: "قيمنا", content: aboutUs?.values ?? "")
    }
    
    func getMessageCell() -> (title: String, content: String) {
        return (title: "رسالتنا", content: aboutUs?.message ?? "")
    }

    func getGoalsCell() -> (title: String, content: String) {
        return (title: "أهدافنا", content: aboutUs?.goals ?? "")
    }

}
