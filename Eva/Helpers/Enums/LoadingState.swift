//
//  LoadingState.swift
//  MYWE
//
//  Created by AmrFawaz on 04/10/2021.
//  Copyright © 2021 Segmatek. All rights reserved.
//

import Foundation

enum LoadingState {
    case loading
    case ready
    case error(error: String)
}
