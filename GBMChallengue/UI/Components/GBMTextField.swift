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
        imageView.tintColor = .systemBackground
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.changePasswordIcon)))
        rightView = imageView
    }
    
    @objc private func changePasswordIcon() {
        isPasswordCovered = !isPasswordCovered
        passwordImage.image = isPasswordCovered ? coverPasswordImage : showPasswordImage
        self.isSecureTextEntry = !isPasswordCovered
    }
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.leftViewRect(forBounds: bounds)
        textRect.origin.x += .eight
        return textRect
    }
    
    override func awakeFromNib() {
        self.roundCorners(.allCorners, radius: .eight)
        self.setUpMargins(color: .systemBackground)
    }
}
