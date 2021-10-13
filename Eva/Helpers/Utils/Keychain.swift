//
//  Keychain.swift
//  MYWE
//
//  Created by AmrFawaz on 05/10/2021.
//  Copyright © 2021 Segmatek. All rights reserved.
//

import Foundation
import KeychainSwift

struct KeychainKeys {
    private init() {}
}

class Keychain {
    static let shared = Keychain()
    private let keychain = KeychainSwift()

    func set<T>(value: T?, forKey key: String) {
        guard value != nil else {
            return
        }
        switch value {
        case is String:
            keychain.set(value as! String, forKey: key)
        case is Bool:
            keychain.set(value as! Bool, forKey: key)
        case is Data:
            keychain.set(value as! Data, forKey: key)
        default:
            break
        }
    }

    func getBool(forKey key: String) -> Bool? {
        return keychain.getBool(key)
    }

    func getString(forKey key: String) -> String? {
        return keychain.get(key)
    }

    func getData(forKey key: String) -> Data? {
        return keychain.getData(key)
    }

    func removeValue(forKey key: String) {
        keychain.delete(key)
    }

    func remvoeClearKeychain() {
        keychain.clear()
    }
}
