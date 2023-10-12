//
//  GBMDashedButton.swift
//  GBMChallengue
//
//  Created by javier pineda on 11/10/23.
//

import UIKit

class GBMDashedButton: UIButton {
    var dashedLine = CAShapeLayer()
    
    override func awakeFromNib() {
        setUp()
    }
    
    private func setUp() {
        dashedLine.strokeColor = UIColor.secondaryLabel.cgColor
        dashedLine.lineWidth = .two
        titleLabel?.font = .systemFont(ofSize: .ten, weight: .semibold)
        setTitleColor(.label, for: .normal)
        layer.addSublayer(dashedLine)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let path = UIBezierPath()
        path.move(to: CGPoint(x: bounds.minX, y: bounds.maxY))
        path.addLine(to: CGPoint(x: bounds.maxX, y: bounds.maxY))
        dashedLine.lineDashPattern = [8, 3]
        dashedLine.path = path.cgPath
    }
}
