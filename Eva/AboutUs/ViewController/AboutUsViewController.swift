//
//  AboutUsViewController.swift
//  Eva
//
//  Created by AmrFawaz on 30/10/2021.
//  Copyright © 2021 AmrFawaz. All rights reserved.
//

import UIKit

class AboutUsViewController: UIViewController {

    // MARK: Outlets:

    @IBOutlet weak var tableview: UITableView!
    
    private let viewModel: AboutUsViewModel
    private weak var activityIndicator: UIActivityIndicatorView!

    // MARK: - Initializers
    init(viewModel: AboutUsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "AboutUsViewController", bundle: nil)
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
        tableview.register(UINib(nibName: Constants.CellsIdentefires.AboutUsMainCell, bundle: nil), forCellReuseIdentifier: Constants.CellsIdentefires.AboutUsMainCell)
        tableview.register(UINib(nibName: Constants.CellsIdentefires.AboutUsCell, bundle: nil), forCellReuseIdentifier: Constants.CellsIdentefires.AboutUsCell)

    }

    // MARK: - Actions
    @IBAction func buttonBackClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension AboutUsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.getAboutUsItemsCount()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch viewModel.getAboutUsItems()[indexPath.section] {
        case .aboutUs:
            let aboutUsCell = tableview.dequeueReusableCell(withIdentifier: Constants.CellsIdentefires.AboutUsMainCell) as? AboutUsMainCell
            let aboutUs = viewModel.getAboutUsMainCell()
            aboutUsCell?.configureCell(title: aboutUs.title, content: aboutUs.content)
            return aboutUsCell!
            
        case .values(let opened):
            let aboutUsCell = tableview.dequeueReusableCell(withIdentifier: Constants.CellsIdentefires.AboutUsCell) as? AboutUsCell
            aboutUsCell?.configureCell(title: viewModel.getValuesCell().title, content: viewModel.getValuesCell().content, opened: opened)
            return aboutUsCell!

        case .message(let opened):
            let aboutUsCell = tableview.dequeueReusableCell(withIdentifier: Constants.CellsIdentefires.AboutUsCell) as? AboutUsCell
            aboutUsCell?.configureCell(title: viewModel.getMessageCell().title, content: viewModel.getMessageCell().content, opened: opened)
            return aboutUsCell!
            
        case .goals(let opened):
            let aboutUsCell = tableview.dequeueReusableCell(withIdentifier: Constants.CellsIdentefires.AboutUsCell) as? AboutUsCell
            aboutUsCell?.configureCell(title: viewModel.getGoalsCell().title, content: viewModel.getGoalsCell().content, opened: opened)
            return aboutUsCell!
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch viewModel.getAboutUsItems()[indexPath.section] {
        case .values(let opened):
            viewModel.setValuesCellOpend(isOpen: !opened)
            tableview.beginUpdates()
            tableview.reloadRows(at: [indexPath], with: .automatic)
            tableview.endUpdates()
        case .message(let opened):
            viewModel.setMessageCellOpend(isOpen: !opened)
            tableview.beginUpdates()
            tableview.reloadRows(at: [indexPath], with: .automatic)
            tableview.endUpdates()
        case .goals(let opened):
            viewModel.setGoalsCellOpend(isOpen: !opened)
            tableview.beginUpdates()
            tableview.reloadRows(at: [indexPath], with: .automatic)
            tableview.endUpdates()
        default:
            break
        }
    }

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch viewModel.getAboutUsItems()[indexPath.section] {
        case .values(let opened), .message(let opened), .goals(let opened):
            if (opened) {
                return UITableView.automaticDimension
            } else {
                return 60
            }
        default:
            return UITableView.automaticDimension
        }
    }

    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 8
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        switch viewModel.getAboutUsItems()[section] {
        case .goals:
            return 16
        default: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 8))
        footerView.backgroundColor = #colorLiteral(red: 0.9215686275, green: 0.9333333333, blue: 0.9490196078, alpha: 1)
        return footerView
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 16))
        footerView.backgroundColor = #colorLiteral(red: 0.9215686275, green: 0.9333333333, blue: 0.9490196078, alpha: 1)
        return footerView
    }
}

extension AboutUsViewController: AboutUsDelegate {
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
