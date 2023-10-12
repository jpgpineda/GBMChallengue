//
//  UILabel+Ext.swift
//  GBMChallengue
//
//  Created by javier pineda on 11/10/23.
//

import UIKit

extension UILabel {
    @IBInspectable var localized: String {
        set {
            text = .Localized.getLocalizedString(newValue)
        }
        get {
            return text ?? .empty
        }
    }
}
