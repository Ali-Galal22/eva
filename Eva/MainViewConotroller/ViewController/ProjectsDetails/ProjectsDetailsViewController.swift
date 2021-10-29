//
//  ProjectsDetailsViewController.swift
//  Eva
//
//  Created by AmrFawaz on 23/10/2021.
//  Copyright © 2021 AmrFawaz. All rights reserved.
//

import UIKit

class ProjectsDetailsViewController: UIViewController {

    
    // MARK: - Outlets
    @IBOutlet weak var tableview: UITableView!
    
    private let viewModel: ProjectsDetailsViewModel
    private weak var activityIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator = view.addLoadingIndicator()
        viewModel.configure(with: self)
        registerCells()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    // MARK: - Initializers
    init(viewModel: ProjectsDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "ProjectsDetailsViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func registerCells() {
        tableview.register(UINib(nibName: Constants.CellsIdentefires.ProjectDetailsMainImageCell, bundle: nil), forCellReuseIdentifier: Constants.CellsIdentefires.ProjectDetailsMainImageCell)
        tableview.register(UINib(nibName: Constants.CellsIdentefires.ProjectInfoCell, bundle: nil), forCellReuseIdentifier: Constants.CellsIdentefires.ProjectInfoCell)
        tableview.register(UINib(nibName: Constants.CellsIdentefires.MapCell, bundle: nil), forCellReuseIdentifier: Constants.CellsIdentefires.MapCell)
        tableview.register(UINib(nibName: Constants.CellsIdentefires.ProjectDetailsCell, bundle: nil), forCellReuseIdentifier: Constants.CellsIdentefires.ProjectDetailsCell)
        tableview.register(UINib(nibName: Constants.CellsIdentefires.ProjectFeatureCell, bundle: nil), forCellReuseIdentifier: Constants.CellsIdentefires.ProjectFeatureCell)
        tableview.register(UINib(nibName: Constants.CellsIdentefires.ProjectBenifitsCell, bundle: nil), forCellReuseIdentifier: Constants.CellsIdentefires.ProjectBenifitsCell)
        
    }
    


}

extension ProjectsDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.getCells().count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch viewModel.getCells()[section] {
        case .gallary, .projectInfo, .map, .projectDetails, .features:
            return 1
        case .benifits:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch viewModel.getCells()[indexPath.section] {
        case .gallary:
            let mainCell = tableview.dequeueReusableCell(withIdentifier: Constants.CellsIdentefires.ProjectDetailsMainImageCell) as? ProjectDetailsMainImageCell
            mainCell?.delegate = self
            mainCell?.configureCell(gallary: viewModel.getGallary())
            return mainCell!
        case .projectInfo:
            let projectInfoCell = tableView.dequeueReusableCell(withIdentifier: Constants.CellsIdentefires.ProjectInfoCell) as? ProjectInfoCell
            let projectInfo = viewModel.getProjectInfoCell()
            projectInfoCell?.configureCell(projectType: projectInfo.projectType, projectTitle: projectInfo.projectTitle, projectExcerpt: projectInfo.projectExcerpt)
            return projectInfoCell!
        case .map:
            let mapCell = tableView.dequeueReusableCell(withIdentifier: Constants.CellsIdentefires.MapCell) as? MapCell
            mapCell?.configureCell(html: viewModel.getMapHTML())
            return mapCell!
        case .projectDetails:
            let projectDetailsCell = tableView.dequeueReusableCell(withIdentifier: Constants.CellsIdentefires.ProjectDetailsCell) as? ProjectDetailsCell
            let projectDetails = viewModel.getProjectDetailsCell()
            projectDetailsCell?.configureCell(startDate: projectDetails.startDate, endDate: projectDetails.endDate, projectStatus: projectDetails.projectStatus, projectLocation: projectDetails.porjectLocation, projectType: projectDetails.projectType)
            return projectDetailsCell!
            
        case .features(let opened):
            let projectFeaturesCell = tableView.dequeueReusableCell(withIdentifier: Constants.CellsIdentefires.ProjectFeatureCell) as? ProjectFeatureCell
            projectFeaturesCell?.configureCell(projectDetails: viewModel.getProjectFeaturesCell(), opened: opened)
            return projectFeaturesCell!
        case .benifits(let opened):
            let brojectBenifitsCell = tableView.dequeueReusableCell(withIdentifier: Constants.CellsIdentefires.ProjectBenifitsCell) as? ProjectBenifitsCell
            brojectBenifitsCell?.configureCell(roomsNumber: viewModel.getProjectBenifitsCell().roomsNumber, kitchenNumber: viewModel.getProjectBenifitsCell().kitchensNumber, isHasElevator: viewModel.getProjectBenifitsCell().hasElevators, opened: opened)
            return brojectBenifitsCell!
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch viewModel.getCells()[indexPath.section] {
        case .features(let opened):
            viewModel.setFeatureCellOpend(isOpen: !opened)
            tableview.beginUpdates()
            tableview.reloadRows(at: [indexPath], with: .automatic)
            tableview.endUpdates()
        case .benifits(let opened):
            viewModel.setBenifitsCellOpend(isOpen: !opened)
            tableview.beginUpdates()
            tableview.reloadRows(at: [indexPath], with: .automatic)
            tableview.endUpdates()
        default:
            break
        }
    }

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch viewModel.getCells()[indexPath.section] {
        case .features(let opened):
            if (opened) {
                return UITableView.automaticDimension
            } else {
                return 60
            }
        case .benifits(let opened):
            if (opened) {
                return 289
            } else {
                return 60
            }
        default: return UITableView.automaticDimension
        }
    }
}

extension ProjectsDetailsViewController: ProjectsDetailsDelegate {
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
extension ProjectsDetailsViewController: ProjectDetailsMainImageCellDelegate {
    func showInterestView() {
        viewModel.showInterest()
    }
    
    func dismissView() {
        self.dismiss(animated: true, completion: nil)
    }
}


