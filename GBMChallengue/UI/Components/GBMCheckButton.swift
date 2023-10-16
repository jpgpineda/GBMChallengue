//
//  GBMCheckButton.swift
//  GBMChallengue
//
//  Created by javier pineda on 15/10/23.
//

import UIKit

class GBMCheckButton: UIButton {
    let checkedImage = UIImage(systemName: "square.fill")
    let uncheckedImage = UIImage(systemName: "square")
    
    var isChecked: Bool = false {
        didSet {
            if isChecked {
                self.setImage(checkedImage, for: .normal)
            } else {
                self.setImage(uncheckedImage, for: .normal)
            }
        }
    }
    
    override func awakeFromNib() {
        self.addTarget(self, action: #selector(buttonClicked(sender:)), for: .touchUpInside)
        self.isChecked = false
        tintColor = .label
    }
    
    @objc func buttonClicked(sender: UIButton) {
        if sender == self {
            isChecked = !isChecked
        }
    }
}

