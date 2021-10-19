//
//  AppConfigurations.swift
//  Eva
//
//  Created by AmrFawaz on 10/10/2021.
//  Copyright © 2021 AmrFawaz. All rights reserved.
//

import Foundation
class Configurations: NSObject {

    // MARK: - Environments
    static var baseUrl: URL {
        return URL(string: "https://demo.evaresc.com/api/")!
    }
}
