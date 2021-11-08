//
//  ProjectsDetailsViewModel.swift
//  Eva
//
//  Created by AmrFawaz on 23/10/2021.
//  Copyright © 2021 AmrFawaz. All rights reserved.
//

import Foundation

protocol ProjectsDetailsDelegate: AnyObject {
    func onStateChanged(state: LoadingState)
}

protocol ProjectsDetailsViewModelCoordinator {
    func navigateToProjectInterst(project: Project)
}

enum ProjectDetailsCells {
    case gallary
    case projectInfo
    case map
    case projectDetails
    case features(opened: Bool = false)
    case benifits(opened: Bool = false)
}

class ProjectsDetailsViewModel {
    private let coordinator: ProjectsDetailsViewModelCoordinator
    private unowned var delegate: ProjectsDetailsDelegate?
    private var projectDetails: ProjectDetails?
    private var projectId: Int
    private var projectDetailsCells : [ProjectDetailsCells] = []
    
    
    private var featureCell: ProjectDetailsCells = .features(opened: false)
    private var benifitsCell: ProjectDetailsCells = .benifits(opened: false)
    // MARK: - State management
    private var state: LoadingState = .loading {
        didSet {
            delegate?.onStateChanged(state: state)
        }
    }
    
    // MARK: - Initializer

    init(coordinator: ProjectsDetailsViewModelCoordinator, projectId: Int) {
        self.coordinator = coordinator
        self.projectId = projectId
        self.projectDetailsCells = [.gallary, .projectInfo, .map, .projectDetails, featureCell, benifitsCell]
    }

    func configure(with delegate: ProjectsDetailsDelegate) {
        self.delegate = delegate
        loadData()
    }
    
    
    private func loadData() {
        APIClient.getProjectDetails(parameters: ["action": "project", "id": "\(projectId)"]) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.projectDetails = response.data
                self.delegate?.onStateChanged(state: .ready())
            case .failure(let error):
                self.delegate?.onStateChanged(state: .error(error: error.localizedDescription))
            }
        }
    }
    
    func getCells() -> [ProjectDetailsCells] {
        return [.gallary, .projectInfo, .map, .projectDetails, featureCell, benifitsCell]
    }
    
    func getBenifitsCount() -> Int {
        return projectDetails?.features?.count ?? 0
    }
    
    func getGallary() -> [Gallary] {
        self.projectDetails?.gallery ?? []
    }
    
    func getProjectInfoCell() -> (projectType: String, projectTitle: String, projectExcerpt: String) {
        return (projectDetails?.type?.first?.name ?? "", projectDetails?.project?.title ?? "", projectDetails?.project?.excerpt ?? "")
    }
    
    func getMapHTML() -> String {
        return projectDetails?.meta?.map ?? ""
    }
    
    func getProjectDetailsCell() -> (startDate: String, endDate: String, projectStatus: String, porjectLocation: String, projectType: String) {
        return (projectDetails?.meta?.date_start ?? "-", projectDetails?.meta?.date_end ?? "-", projectDetails?.status?.first?.name ?? "-", projectDetails?.location?.first?.name ?? "-", "-")
    }
    
    func getProjectFeaturesCell() -> String {
        return projectDetails?.project?.content ?? ""
    }
    
    func setFeatureCellOpend(isOpen: Bool) {
        featureCell = .features(opened: isOpen)
    }

    func setBenifitsCellOpend(isOpen: Bool) {
        benifitsCell = .benifits(opened: isOpen)
    }
    
    func getProjectBenifitsCell(index: Int) -> (benifitName: String, benifitValue: String, benifitType: String, benifitIcon: String) {
        let benifit = projectDetails?.features?[index - 1]
        return (benifit?.name ?? "", benifit?.value ?? "", benifit?.type ?? "", benifit?.image ?? "")
    }
    
    func showInterest() {
        if let project = projectDetails?.project {
            coordinator.navigateToProjectInterst(project: project)
        }
    }
}
