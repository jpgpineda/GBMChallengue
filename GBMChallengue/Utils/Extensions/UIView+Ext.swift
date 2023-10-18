//
//  UIView+Ext.swift
//  GBMChallengue
//
//  Created by javier pineda on 11/10/23.
//

import UIKit

extension UIView {
    
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        self.addGestureRecognizer(tap)
    }
        
    @objc func dismissKeyboard() {
        self.endEditing(true)
    }
    
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        if #available(iOS 11, *) {
            self.clipsToBounds = true
            self.layer.cornerRadius = radius
            var masked = CACornerMask()
            if corners.contains(.topLeft) { masked.insert(.layerMinXMinYCorner) }
            if corners.contains(.topRight) { masked.insert(.layerMaxXMinYCorner) }
            if corners.contains(.bottomLeft) { masked.insert(.layerMinXMaxYCorner) }
            if corners.contains(.bottomRight) { masked.insert(.layerMaxXMaxYCorner) }
            self.layer.maskedCorners = masked
        } else {
            let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            layer.mask = mask
        }
    }
    
    func setUpMargins(color: UIColor) {
        roundCorners(.allCorners, radius: .eight)
        layer.cornerRadius = .eight
        layer.borderWidth  = .one
        layer.borderColor  = color.cgColor
    }
    
    func setupGradient() {
        let gradientLayer = CAGradientLayer()
        layer.cornerRadius = .fifthTeen
        gradientLayer.frame = frame
        gradientLayer.bounds = bounds
        gradientLayer.cornerRadius = .fifthTeen
        gradientLayer.colors = [UIColor.black, UIColor.lightGray]
        gradientLayer.startPoint = CGPoint(x: .zero, y: Int.one)
        gradientLayer.endPoint = CGPoint(x: Int.one, y: .zero)
        layer.insertSublayer(gradientLayer, at: .zero)
    }
}
