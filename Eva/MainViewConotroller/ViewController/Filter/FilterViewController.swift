//
//  FilterViewController.swift
//  Eva
//
//  Created by AmrFawaz on 14/10/2021.
//  Copyright © 2021 AmrFawaz. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var barButtonBack: UIBarButtonItem!
    @IBOutlet weak var buttonResetFilter: UIButton!
    private weak var activityIndicator: UIActivityIndicatorView!

    private let viewModel: MainViewModel

    // MARK: - Initializers

    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "FilterViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator = view.addLoadingIndicator()
        viewModel.configure(with: self, view: .filter)
        registerCells()
    }

    private func registerCells() {
        tableView.register(UINib(nibName: Constants.CellsIdentefires.FilterCell, bundle: nil), forCellReuseIdentifier: Constants.CellsIdentefires.FilterCell)
        tableView.register(UINib(nibName: Constants.CellsIdentefires.FilterRoomNumberCell, bundle: nil), forCellReuseIdentifier: Constants.CellsIdentefires.FilterRoomNumberCell)
        self.tableView.register(UINib(nibName: Constants.CellsIdentefires.FilterHeaderView, bundle: nil), forHeaderFooterViewReuseIdentifier: Constants.CellsIdentefires.FilterHeaderView)
        tableView.register(UINib(nibName: Constants.CellsIdentefires.FilterButtonCell, bundle: nil), forCellReuseIdentifier: Constants.CellsIdentefires.FilterButtonCell)
    }
    
    // MARK: - Actions
    
    @IBAction func barButtonBackClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func buttonResetFilterClicked(_ sender: Any) {
        viewModel.resetFilter()
    }
    
    
}


extension FilterViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.getFilterSecions().count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch viewModel.getFilterSecions()[section] {
        case .location(let items, _, _):
            return items.count
        case .type(let items, _, _):
            return items.count
        case .roomsNumber(let items, _):
            return items.count
        case .status(let items, _, _):
            return items.count
        case .filter(let items):
            return items.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        let row = indexPath.row
        let filterCell = tableView.dequeueReusableCell(withIdentifier: Constants.CellsIdentefires.FilterCell) as? FilterCell
        switch viewModel.getFilterSecions()[section] {
        case .location(let items, let selecetdIndex, _):
            filterCell?.labelFilterTitles.text = items[row]
            if let index = selecetdIndex, index == row {
                filterCell?.imageViewCheckbox.image = UIImage(named: "filter-selected")
            } else {
                filterCell?.imageViewCheckbox.image = UIImage(named: "filter-unselecetd")
            }
        case .type(let items, let selecetdIndex, _):
            filterCell?.labelFilterTitles.text = items[row]
            if let index = selecetdIndex, index == row {
                filterCell?.imageViewCheckbox.image = UIImage(named: "filter-selected")
            } else {
                filterCell?.imageViewCheckbox.image = UIImage(named: "filter-unselecetd")
            }

        case .roomsNumber(let items, let roomsNumber):
            let filterRoomNumbersCell = tableView.dequeueReusableCell(withIdentifier: Constants.CellsIdentefires.FilterRoomNumberCell) as? FilterRoomNumberCell
            filterRoomNumbersCell?.delegate = self
            filterRoomNumbersCell?.labelRoomsNumber.text = items[row]
            filterRoomNumbersCell?.labelCount.text = "\(roomsNumber ?? 0)"
            return filterRoomNumbersCell!

        case .status(let items, let selecetdIndex, _):
            filterCell?.labelFilterTitles.text = items[row]
            if let index = selecetdIndex, index == row {
                filterCell?.imageViewCheckbox.image = UIImage(named: "filter-selected")
            } else {
                filterCell?.imageViewCheckbox.image = UIImage(named: "filter-unselecetd")
            }
        case .filter(_):
            let filterButtonCell = tableView.dequeueReusableCell(withIdentifier: Constants.CellsIdentefires.FilterButtonCell) as? FilterButtonCell
            filterButtonCell?.delegate = self
            return filterButtonCell!


        }
        return filterCell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch viewModel.getFilterSecions()[indexPath.section] {
        case .filter:
            return 70
        default:
            return 60
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch viewModel.getFilterSecions()[section] {
        case .roomsNumber, .filter:
            return 0
        default:
            return 60
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "FilterHeaderView") as? FilterHeaderView
        switch viewModel.getFilterSecions()[section] {
        case .location:
            headerView?.labelHeaderTitle.text = "موقع العقار"
        case .type:
            headerView?.labelHeaderTitle.text = "نوع العقار"
        case .roomsNumber:
            headerView?.labelHeaderTitle.text = ""
        case .status:
            headerView?.labelHeaderTitle.text = "حالة العقار"
        default:
            return nil
        }
        return headerView

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = indexPath.section
        let row = indexPath.row
        viewModel.setSelectedItem(for: section, itemIndex: row)
        reloadTableView()
    }
    
    func reloadTableView() {
        tableView.reloadData()
    }
}

extension FilterViewController: MainListDelegate {
    func onStateChanged(state: LoadingState) {
        switch state {
        case .loading:
            activityIndicator.startAnimating()
        case .ready(let api):
            switch api {
            case .filter(queryParameters: [:]), .homeList(queryParameters: [:]):
                self.dismiss(animated: true, completion: nil)
            default:
                break
            }
            activityIndicator.stopAnimating()
            tableView.reloadData()
        case .error:
            activityIndicator.stopAnimating()
            // TODO: handle error case by showing an error view with a retry button
            break
        }
    }

    
}



extension FilterViewController: FilterRoomNumberCellDelegate {
    func plus() {
        viewModel.incrementRooms()
        self.reloadTableView()
    }
    
    func minus() {
        viewModel.decrementRooms()
        self.reloadTableView()
    }
}

extension FilterViewController: FilterButtonCellDelegate {
    func filter() {
        viewModel.filter()
    }
}
