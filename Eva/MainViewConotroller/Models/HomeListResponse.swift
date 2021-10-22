//
//  ServicesResponse.swift
//  Eva
//
//  Created by AmrFawaz on 13/10/2021.
//  Copyright © 2021 AmrFawaz. All rights reserved.
//

import Foundation
struct HomeListResponse: Codable {
    let title: String?
    let about: HomeAboutObject?
    let services: [Service]?
    let projects: [Project]?
}

struct HomeAboutObject: Codable {
    let title: String?
    let ID: Int?
    let content: String?
    let excerpt: String?
    let date: String?
}
