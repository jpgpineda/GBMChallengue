//
//  User.swift
//  GBMChallengue
//
//  Created by javier pineda on 15/10/23.
//

import Foundation

enum UserKeys: String {
    case isLocalAuthEnabled
    case lastSignedUser
}

struct UserPrefs {
    static let shared = UserPrefs()
    let defaults = UserDefaults.standard
    
    internal func saveIsLocalAuthEnabled(isEnabled: Bool) {
        defaults.set(isEnabled, forKey: UserKeys.isLocalAuthEnabled.rawValue)
    }
    
    internal func getIsLocalAuthEnabled() -> Bool? {
        return defaults.object(forKey: UserKeys.isLocalAuthEnabled.rawValue) as? Bool
    }
    
    internal func saveLastSignedUser(email: String) {
        defaults.set(email, forKey: UserKeys.lastSignedUser.rawValue)
    }
    
    internal func getLastSignedUser() -> String {
        return defaults.string(forKey: UserKeys.lastSignedUser.rawValue) ?? .empty
    }
}
