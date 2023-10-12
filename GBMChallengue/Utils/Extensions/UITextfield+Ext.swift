//
//  UITextfield+Ext.swift
//  GBMChallengue
//
//  Created by javier pineda on 11/10/23.
//

import UIKit

extension UITextField {
    @IBInspectable var hintLocalized: String {
        set {
            placeholder = .Localized.getLocalizedString(newValue)
        }
        get {
            return placeholder ?? .empty
        }
    }
}
