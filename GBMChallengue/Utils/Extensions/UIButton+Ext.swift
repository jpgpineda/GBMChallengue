//
//  UIButton+Ext.swift
//  GBMChallengue
//
//  Created by javier pineda on 11/10/23.
//

import UIKit

extension UIButton {
    @IBInspectable var localized: String {
        set {
            setTitle(.Localized.getLocalizedString(newValue), for: .normal)
        }
        get {
            return title(for: .normal) ?? .empty
        }
    }
    
    var isFavorite: Bool {
        set {
            setImage(newValue ? UIImage(systemName: "star.fill") : UIImage(systemName: "star"), for: .normal)
        }
        get {
            return false
        }
    }
}
