//
//  RequestParamters.swift
//  MYWE
//
//  Created by AmrFawaz on 28/09/2021.
//  Copyright © 2021 Segmatek. All rights reserved.
//

import Foundation

protocol RequestParamters: Codable {
    func getParamsAsJson() -> [String: Any]
}

extension RequestParamters {
    func getParamsAsJson() -> [String: Any] {
        let jsonEncoder = JSONEncoder()

        guard let jsonData = try? jsonEncoder.encode(self) else {
            return [:]
        }
        guard let dictionary = try? JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as? [String: Any] else {
            return [:]
        }

        return dictionary
    }
}
