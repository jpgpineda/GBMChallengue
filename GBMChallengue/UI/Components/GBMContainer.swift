//
//  GBMContainer.swift
//  GBMChallengue
//
//  Created by javier pineda on 11/10/23.
//

import UIKit

class GBMContainer: UIView {
    override func awakeFromNib() {
        backgroundColor = .secondarySystemBackground
        hideKeyboardWhenTappedAround()
        roundCorners(.topLeft, radius: .forty)
    }
}
