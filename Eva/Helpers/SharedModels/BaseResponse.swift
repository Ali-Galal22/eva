//
//  BaseResponse.swift
//  MYWE
//
//  Created by AmrFawaz on 30/09/2021.
//  Copyright © 2021 Segmatek. All rights reserved.
//

import Foundation

class BaseResponse <T:Codable>: RequestParamters {
    var status: Int?
    var data: T?
}
