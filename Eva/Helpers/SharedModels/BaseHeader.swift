//
//  BaseHeaderResponse.swift
//  MYWE
//
//  Created by AmrFawaz on 29/09/2021.
//  Copyright © 2021 Segmatek. All rights reserved.
//

import Foundation

struct BaseHeader: Codable {
    var timestamp: String? = "\(Date().toMillis() ?? 0)"
    var customerId: String?
    let msisdn: String?
    var messageCode: String?
    var responseCode: String?
    var responseMessage: String?
    var locale: String? = "en"
    var referenceId: String?
    
    
}

extension Date {
    func toMillis() -> Int64! {
        return Int64(self.timeIntervalSince1970 * 1000)
    }
}
