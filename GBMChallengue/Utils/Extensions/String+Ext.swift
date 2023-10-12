//
//  String+Ext.swift
//  GBMChallengue
//
//  Created by javier pineda on 11/10/23.
//

import Foundation

extension String {
    static let empty: String = ""
    
    func isValidEmail() -> Bool {
        let emailTest = NSPredicate(format: "SELF MATCHES %@", Regex.emailRegex)
        return emailTest.evaluate(with: self)
    }
    
    func isPasswordValid() -> Bool {
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", Regex.passwordRegex)
        return passwordTest.evaluate(with: self)
    }
}
