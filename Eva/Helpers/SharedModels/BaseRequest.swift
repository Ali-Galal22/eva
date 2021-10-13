//
//  BaseRequest.swift
//  MYWE
//
//  Created by AmrFawaz on 29/09/2021.
//  Copyright © 2021 Segmatek. All rights reserved.
//

import Foundation

class BaseRequest <T:Codable>: RequestParamters {
    var header: BaseHeader?
    var body: T?
}
