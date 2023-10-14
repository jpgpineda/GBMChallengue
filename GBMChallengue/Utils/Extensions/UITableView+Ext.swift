//
//  UITableView+Ext.swift
//  GBMChallengue
//
//  Created by javier pineda on 13/10/23.
//

import UIKit

extension UITableView {
    func registerCell(_ identifier: String) {
        self.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
    }
}
