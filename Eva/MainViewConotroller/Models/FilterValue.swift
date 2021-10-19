//
//  FilterValue.swift
//  Eva
//
//  Created by AmrFawaz on 18/10/2021.
//  Copyright © 2021 AmrFawaz. All rights reserved.
//

import Foundation

struct FilterValue: Codable {
    let type: [String: String]?
    let location: [String: String]?
    let status: [String: String]?
}
