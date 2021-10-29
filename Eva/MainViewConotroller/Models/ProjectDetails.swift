//
//  ProjectDetails.swift
//  Eva
//
//  Created by AmrFawaz on 23/10/2021.
//  Copyright © 2021 AmrFawaz. All rights reserved.
//

import Foundation

struct ProjectDetails: Codable {
    let project: Project?
    let location: [ProjectLocation]?
    let status: [ProjectStatus]?
    let type: [ProjectType]?
    let meta: ProjectInfo?
    let gallery: [Gallary]?
}


struct ProjectLocation: Codable {
    let term_id: Int?
    let name: String?
    let slug: String?
}

struct ProjectStatus: Codable {
    let term_id: Int?
    let name: String?
    let slug: String?
}

struct ProjectType: Codable {
    let term_id: Int?
    let name: String?
    let slug: String?
}

struct ProjectInfo: Codable {
    let rooms_count: String?
    let hall: String?
    let bathroom: String?
    let kitchen: String?
    let space: String?
    let parking: String?
    let elevator: String?
    let tank: String?
    let laundry: String?
    let price: String?
    let date_start: String?
    let date_end: String?
    let status: String?
    let location: String?
    let type: String?
    let views: String?
    let map: String?
}

struct Gallary: Codable {
    let full: String?
    let thumb: String?
    let alt: String?
}
