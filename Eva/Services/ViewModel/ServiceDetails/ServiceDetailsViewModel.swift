//
//  ServiceDetailsViewModel.swift
//  Eva
//
//  Created by AmrFawaz on 22/10/2021.
//  Copyright © 2021 AmrFawaz. All rights reserved.
//

import Foundation

protocol ServiceDetailsViewModelCoordinator {
}

class ServiceDetailsViewModel {
    private let service: Service

    // MARK:- Initializer
    init(service: Service) {
        self.service = service
    }
    
    
    func getServiceImageUrl() -> String {
        return service.image ?? ""
    }
    
    func getServiceTitle() -> String {
        return service.title ?? ""
    }

    func getServiceContent() -> String {
        return service.content ?? ""
    }


}
