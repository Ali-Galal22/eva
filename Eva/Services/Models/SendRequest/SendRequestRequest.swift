//
//  SendRequestRequest.swift
//  Eva
//
//  Created by AmrFawaz on 21/10/2021.
//  Copyright © 2021 AmrFawaz. All rights reserved.
//

import Foundation

struct SendRequestRequest: RequestParamters {
    let name: String?
    let email: String?
    let mobile: String?
    let subject: String? = "أتصل بنا"
    var message: String? = ""
    
    enum CodingKeys: String, CodingKey {
        case name = "your-name"
        case email = "your-email"
        case mobile = "your-mobile"
        case subject = "your-subject"
        case message = "your-message"
    }

}
