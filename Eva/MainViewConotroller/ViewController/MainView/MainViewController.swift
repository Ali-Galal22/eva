//
//  MainViewController.swift
//  Eva
//
//  Created by AmrFawaz on 13/10/2021.
//  Copyright © 2021 AmrFawaz. All rights reserved.
//

import UIKit
typealias Animation = (UITableViewCell, IndexPath, UITableView) -> Void

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
//        test()
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
        homeCell?.cellIndex = indexPath
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            viewModel.navigateToProjectDetails(index: indexPath.row)
        case 1:
            viewModel.navigateToServiecDetails(index: indexPath.row)
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let animation = AnimationFactory.makeFadeAnimation(duration: 0.5, delayFactor: 0.05)
        let animator = Animator(animation: animation)
        animator.animate(cell: cell, at: indexPath, in: tableView)
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
        case .error(let api, _):
            activityIndicator.stopAnimating()
            switch api {
            case .homeList(queryParameters: [:]):
                let errorView = ErrorView()
                errorView.modalPresentationStyle = .overFullScreen
                errorView.onRetry = { [weak self] in
                    guard let self = self else { return }
                    self.viewModel.retryLoadHome()
                    self.dismiss(animated: true, completion: nil)
                }
                self.present(errorView, animated: true, completion: nil)
            default:
                break
            }
            // TODO: handle error case by showing an error view with a retry button
            break
        }
    }

    
}

extension MainViewController: HomeCellDelegate {
    func didClickDetails(index: IndexPath) {
        switch index.section {
        case 0:
            viewModel.navigateToProjectDetails(index: index.row)
        case 1:
            viewModel.navigateToServiecDetails(index: index.row)
        default:
            break
        }

    }
}



