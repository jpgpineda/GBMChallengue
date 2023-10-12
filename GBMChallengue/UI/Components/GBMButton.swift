//
//  GBMButton.swift
//  GBMChallengue
//
//  Created by javier pineda on 11/10/23.
//

import UIKit

class GBMButton: UIButton {
    override func awakeFromNib() {
        setTitleColor(.systemBackground, for: .normal)
        roundCorners([.bottomLeft, .bottomRight, .topLeft], radius: .eight)
        titleLabel?.font = .systemFont(ofSize: .twenty, weight: .bold)
    }
    
    @IBInspectable var isActive: Bool = false {
        didSet {
            backgroundColor = isActive ? .label : .lightGray
            isEnabled = isActive
        }
    }
}
