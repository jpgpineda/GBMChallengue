//
//  UINavigationController+Ext.swift
//  GBMChallengue
//
//  Created by javier pineda on 12/10/23.
//

import UIKit

extension UINavigationController {
    func setupPresentation() {
        modalPresentationStyle = .fullScreen
        modalTransitionStyle = .crossDissolve
    }
}
