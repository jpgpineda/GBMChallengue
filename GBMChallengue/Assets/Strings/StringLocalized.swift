//
//  StringLocalized.swift
//  GBMChallengue
//
//  Created by javier pineda on 10/10/23.
//

import Foundation

extension String {
    struct Localized {
        // MARK: API errors
        static var invalidResponse: String { return getLocalizedString(#function) }
        static var statusCode: String { return getLocalizedString(#function) }
        static var requestFailed: String { return getLocalizedString(#function) }
        static var invalidData: String { return getLocalizedString(#function) }
        static var JSONConversionFailure: String { return getLocalizedString(#function) }
        static var serializationFailed: String { return getLocalizedString(#function) }
        static var JSONParsingFailure: String { return getLocalizedString(#function) }
        static var noInternet: String { return getLocalizedString(#function) }
        static var unsuccessfull: String { return getLocalizedString(#function) }
        static var noActiveSession: String { return getLocalizedString(#function) }
        static var unexpected: String { return getLocalizedString(#function) }
        static var ups: String { return getLocalizedString(#function) }
        
        // MARK: Sign Up
        static var name: String { return getLocalizedString(#function) }
        static var lastName: String { return getLocalizedString(#function) }
        static var register: String { return getLocalizedString(#function) }
        static var email: String { return getLocalizedString(#function) }
        static var password: String { return getLocalizedString(#function) }
        
        // MARK: Sign In
        static var login: String { return getLocalizedString(#function) }
        static var signIn: String { return getLocalizedString(#function) }
        static var newAccountQuestion: String { return getLocalizedString(#function) }
        static var signUp: String { return getLocalizedString(#function) }
        static var restorePassword: String { return getLocalizedString(#function) }
        
        // MARK: Ticker Detail
        static var filterBy: String { return getLocalizedString(#function) }
        static var openPrice: String { return getLocalizedString(#function) }
        static var closePrice: String { return getLocalizedString(#function) }
        static var highPrice: String { return getLocalizedString(#function) }
        static var lowPrice: String { return getLocalizedString(#function) }
        static var volume: String { return getLocalizedString(#function) }
        static var date: String { return getLocalizedString(#function) }
        static var prices: String { return getLocalizedString(#function) }
        
        // MARK: Welcome
        static var begin: String { return getLocalizedString(#function) }
        
        // MARK: Validation Errors
        static var emptyField: String { return getLocalizedString(#function) }
        static var invalidEmail: String { return getLocalizedString(#function) }
        static var invalidPassword: String { return getLocalizedString(#function) }
        
        // MARK: Success messages
        static var congratsTitle: String { return getLocalizedString(#function) }
        static var accountCreated: String { return getLocalizedString(#function) }
        
        internal static func getLocalizedString(_ key: String) -> String {
            return NSLocalizedString(key, comment: key)
        }
    }
}
