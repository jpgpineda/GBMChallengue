//
//  User.swift
//  GBMChallengue
//
//  Created by javier pineda on 15/10/23.
//

import Foundation

enum UserKeys: String {
    case isLocalAuthEnabled
}

struct UserPrefs {
    static let shared = UserPrefs()
    let defaults = UserDefaults.standard
    
    internal func saveIsLocalAuthEnabled(isEnabled: Bool) {
        defaults.set(isEnabled, forKey: UserKeys.isLocalAuthEnabled.rawValue)
    }
    
    internal func getIsLocalAuthEnabled() -> Bool {
        return defaults.bool(forKey: UserKeys.isLocalAuthEnabled.rawValue)
    }
}
