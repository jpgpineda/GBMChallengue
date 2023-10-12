//
//  GBMDashedButton.swift
//  GBMChallengue
//
//  Created by javier pineda on 11/10/23.
//

import UIKit

class GBMDashedButton: UIButton {
    var dashedLine: CAShapeLayer!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }
    
    private func setUp() {
        dashedLine = CAShapeLayer()
        dashedLine.strokeColor = UIColor.label.cgColor
        dashedLine.lineWidth = .two
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
