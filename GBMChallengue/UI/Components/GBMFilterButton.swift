//
//  GBMFilterButton.swift
//  GBMChallengue
//
//  Created by javier pineda on 13/10/23.
//

import UIKit

class GBMFilterButton: UIButton {
    override func awakeFromNib() {
        setTitleColor(.systemBackground, for: .normal)
        roundCorners(.allCorners, radius: .eight)
        titleLabel?.font = .systemFont(ofSize: .ten, weight: .bold)
    }
    
    override var isSelected: Bool {
        didSet {
            backgroundColor = isSelected ? .systemBlue : .separator
        }
    }
}
