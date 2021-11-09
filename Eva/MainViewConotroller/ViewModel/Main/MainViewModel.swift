//
//  MainViewModel.swift
//  Eva
//
//  Created by AmrFawaz on 13/10/2021.
//  Copyright © 2021 AmrFawaz. All rights reserved.
//

import Foundation
protocol MainViewModelCoordinator {
    func navigateToProjectDetails(projectId: Int)
    func navigateToServiceDetails(service: Service)
}
protocol MainListDelegate: AnyObject {
    func onStateChanged(state: LoadingState)
}
extension MainListDelegate {
    func onStateChanged(state: LoadingState){}
}

enum View {
    case home
    case filter
}

enum FilterSections {
    case location(items: [String], selectedIndex: Int?, selectedKeyValue: String?)
    case type(items: [String], selectedIndex: Int?, selectedKeyValue: String?)
    case roomsNumber(items: [String], roomsNumber: Int? = 0)
    case status(items: [String], selectedIndex: Int?, selectedKeyValue: String?)
    case filter(items: [String])
    
    func getSelecetedIndex() -> String? {
        switch self {
        case .location(_, _, let selectedKeyValue):
            return selectedKeyValue
        case .type(_, _, let selectedKeyValue):
            return selectedKeyValue
        case .roomsNumber(_, let roomsNumber):
            return "\(roomsNumber ?? 0)"
        case .status(_, _, let selectedKeyValue):
            return selectedKeyValue
        default:
            return nil
        }
    }
}

enum FilterItems: String {
    case geddah = "جدة"
    case riyadh = "الرياض"
    case villa = "فيلا"
    case appartment = "شقة"
    case roomsnumber = "عدد الغرف"
    case underConstruction = "تحت الانشاء"
    case finished = "مكتمل"
    case filterButton = "تصفية"
}

class MainViewModel {
    private let coordinator: MainViewModelCoordinator
    private var service: [Service]?
    private var projects: [Project]?
    private unowned var delegate: MainListDelegate?

    // MARK: - State management

    private var state: LoadingState = .loading {
        didSet {
            delegate?.onStateChanged(state: state)
        }
    }
    
    private var filterVaues: FilterValue?
    private var filterLocationsItems: [String] = []
    private var filterTypesItems: [String] = []
    private var filterRoomNumbersItems: [String] = []
    private var filterStatusItems: [String] = []
    private var filterButtonItem: [String] = []
    
    private var filterLocationsValues: [String] = []
    private var filterTypesValues: [String] = []
    private var filterRoomNumbersValues: [String] = []
    private var filterStatusValues: [String] = []
    private var filterButtonValues: [String] = []

    
    private var filterLocationSection: FilterSections!
    private var filterTypesSection: FilterSections!
    private var filterRoomsNumberSection: FilterSections!
    private var filterStatusSection: FilterSections!
    private var filterButtonSection: FilterSections!
    

    // MARK: - Initializer
    
    init(coordinator: MainViewModelCoordinator) {
        self.coordinator = coordinator
    }
    
    func configure(with delegate: MainListDelegate, view: View) {
        self.delegate = delegate

        switch view {
        case .home:
            loadData()
        case .filter:
            getFilterValues()
            configureFilterCells()
        }
    }
    
    func getProject(index: Int) -> Project? {
        return projects?[index]
    }
    
    func getService(index: Int) -> Service? {
        return service?[index]
    }


    private func loadData() {
        state = .loading
        getHomeList()
    }
    
    private func getHomeList() {
        self.state = .loading
        APIClient.getHomeList(parameters: ["action": "index"]) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
//                self.service = response.data?.services
                self.projects = response.data?.projects
                self.state = .ready(.homeList(queryParameters: [:]))
            case .failure(let error):
                self.state = .error(.homeList(queryParameters: [:]), error: error.localizedDescription)
            }
        }
    }
    
    func getNumberOfSections() -> Int {
        return 2
    }
    
    func getNumberOfRows(section: Int) -> Int {
        switch section {
        case 0:
            return self.projects?.count ?? 0
        case 1:
            return self.service?.count ?? 0
        default:
            return 0
        }
    }
    
    
    func navigateToProjectDetails(index: Int) {
        if let projectId = getProject(index: index)?.ID {
            coordinator.navigateToProjectDetails(projectId: projectId)
        }
    }
    
    func navigateToServiecDetails(index: Int) {
        if let service = getService(index: index) {
            coordinator.navigateToServiceDetails(service: service)
        }
    }

    func retryLoadHome() {
        getHomeList()
    }

}


extension MainViewModel {
    // Filter Logic
    
    private func getFilterValues() {
        self.state = .loading
        APIClient.getFilterValues(parameters: ["action": "terms"]) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.filterVaues = response.data
                self.configureFilterCells()
                self.state = .ready(.getFilterValues())
            case .failure(let error):
                self.state = .error(error: error.localizedDescription)
            }
        }
    }
    
    func filter() {
        var parameters = [String: String]()
        if let selectedLocation = filterLocationSection.getSelecetedIndex() {
            parameters["location"] = selectedLocation
        }
        if let selectedType = filterTypesSection.getSelecetedIndex() {
            parameters["type"] = selectedType
        }
        if let selectedRoomsNumber = filterRoomsNumberSection.getSelecetedIndex() {
            parameters["rooms"] = "\(selectedRoomsNumber)"
            
        }
        if let selectedStatus = filterStatusSection.getSelecetedIndex() {
            parameters["status"] = selectedStatus
        }
        
        
        // Check if no filter selected 
        if parameters.count == 1 && filterRoomsNumberSection.getSelecetedIndex() == "0" {
            return
        }
        
        parameters["action"] = "filter"

        self.state = .loading
        APIClient.filter(parameters: parameters) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
//                self.service = response.data?.services
                self.projects = response.data?.projects
                self.state = .ready(.filter())
            case .failure(let error):
                self.state = .error(error: error.localizedDescription)
            }
        }
    }
    
    
    private func configureFilterCells() {        
        filterLocationsItems = filterVaues?.location?.values.sorted() ?? []
        filterTypesItems = filterVaues?.type?.values.sorted() ?? []
        filterRoomNumbersItems = ["عدد الغرف"]
        filterStatusItems = filterVaues?.status?.values.sorted() ?? []
        filterButtonItem = ["تصفية"]
        
        filterLocationsValues = filterVaues?.location?.keys.sorted() ?? []
        filterTypesValues = filterVaues?.type?.keys.sorted() ?? []
        filterStatusValues = filterVaues?.status?.keys.sorted() ?? []

        
        filterLocationSection = .location(items: filterLocationsItems, selectedIndex: nil, selectedKeyValue: nil)
        filterTypesSection = .type(items: filterTypesItems, selectedIndex: nil, selectedKeyValue: nil)
        filterRoomsNumberSection = .roomsNumber(items: filterRoomNumbersItems, roomsNumber: 0)
        filterStatusSection = .status(items: filterStatusItems, selectedIndex: nil, selectedKeyValue: nil)
        filterButtonSection = .filter(items: filterButtonItem)

    }
    
    func getFilterSecions() -> [FilterSections] {
        return [filterLocationSection, filterTypesSection, filterRoomsNumberSection, filterStatusSection, filterButtonSection]
    }
    
    func setSelectedItem(for section: Int, itemIndex: Int) {
        switch getFilterSecions()[section] {
        case .location(_ , _, let selectedKeyValue):
            let key = filterVaues?.location?.findKey(forValue: filterLocationsItems[itemIndex])
            
            if selectedKeyValue == key  {
                filterLocationSection = .location(items: filterLocationsItems, selectedIndex: nil, selectedKeyValue: nil)
            } else {
                filterLocationSection = .location(items: filterLocationsItems, selectedIndex: itemIndex, selectedKeyValue: key)
            }
        case .type(_ , _, let selectedKeyValue):
            let key = filterVaues?.type?.findKey(forValue: filterTypesItems[itemIndex])

            if selectedKeyValue == key {
                filterTypesSection = .type(items: filterTypesItems, selectedIndex: nil, selectedKeyValue: nil)
            } else {
                filterTypesSection = .type(items: filterTypesItems, selectedIndex: itemIndex, selectedKeyValue: key)
            }
        case .status(_ , _, let selectedKeyValue):
            let key = filterVaues?.status?.findKey(forValue: filterStatusItems[itemIndex])

            if selectedKeyValue == key {
                filterStatusSection = .status(items: filterStatusItems, selectedIndex: nil, selectedKeyValue: nil)
            } else {
                filterStatusSection = .status(items: filterStatusItems, selectedIndex: itemIndex, selectedKeyValue: key)
            }
        default:
            break
        }
    }
    
    private func setRoomsNumber(roomsNumber: Int) {
        filterRoomsNumberSection = .roomsNumber(items: filterRoomNumbersItems, roomsNumber: roomsNumber)
        
    }
    
    func incrementRooms() {
        switch getFilterSecions()[2] {
        case .roomsNumber( _, let roomsNumber):
            setRoomsNumber(roomsNumber: (roomsNumber ?? 0) + 1)
        default:
            break
        }
    }
    
    func decrementRooms() {
        switch getFilterSecions()[2] {
        case .roomsNumber( _, let roomsNumber):
            if (roomsNumber ?? 0) > 1 {
                setRoomsNumber(roomsNumber: (roomsNumber ?? 0) - 1)
            }
        default:
            break
        }
    }
    
    func resetFilter() {
        filterLocationSection = .location(items: filterLocationsItems, selectedIndex: nil, selectedKeyValue: nil)
        filterTypesSection = .type(items: filterTypesItems, selectedIndex: nil, selectedKeyValue: nil)
        filterStatusSection = .status(items: filterStatusItems, selectedIndex: nil, selectedKeyValue: nil)
        filterRoomsNumberSection = .roomsNumber(items: filterRoomNumbersItems, roomsNumber: 0)
        
        getHomeList()
    }
        
}


extension Dictionary where Value: Equatable {
    func findKey(forValue val: Value) -> Key? {
        return first(where: { $1 == val })?.key
    }
}
