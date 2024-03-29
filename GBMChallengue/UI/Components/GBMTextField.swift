//
//  GBMTextField.swift
//  GBMChallengue
//
//  Created by javier pineda on 11/10/23.
//

import UIKit

class GBMTextField: UITextField {
    private let showPasswordImage: UIImage? = UIImage(systemName: "eye")
    private let coverPasswordImage: UIImage? = UIImage(systemName: "eye.slash")
    private let passwordImage: UIImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
    @IBInspectable var isPassword: Bool = false {
        didSet {
            if isPassword {
                isSecureTextEntry = true
                setupPasswordIcon()
            }
        }
    }
    
    private var isPasswordCovered: Bool = false
    
    private func setupPasswordIcon() {
        rightViewMode = UITextField.ViewMode.always
        let imageView = passwordImage
        imageView.contentMode = .scaleAspectFit
        imageView.image = showPasswordImage
        imageView.tintColor = .label
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.changePasswordIcon)))
        imageView.isUserInteractionEnabled = true
        rightView = imageView
    }
    
    @objc private func changePasswordIcon() {
        isPasswordCovered = !isPasswordCovered
        passwordImage.image = isPasswordCovered ? coverPasswordImage : showPasswordImage
        isSecureTextEntry = !isPasswordCovered
    }
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.rightViewRect(forBounds: bounds)
        textRect.origin.x += .minusEight
        return textRect
    }
    
    override func awakeFromNib() {
        setUpMargins(color: .secondaryLabel)
    }
}
