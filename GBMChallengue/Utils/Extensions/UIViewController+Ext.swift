//
//  UIViewController+Ext.swift
//  GBMChallengue
//
//  Created by javier pineda on 11/10/23.
//

import UIKit

extension UIViewController {
    func showLoader() {
        guard let viewController = ModuleManager.toolsDependency.makeLoaderViewController() else { return }
        addChild(viewController)
        guard let loaderView = viewController.view else { return }
        loaderView.tag = 100
        view.addSubview(loaderView)
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        viewController.didMove(toParent: self)
    }
    
    func dismissLoader() {
        guard let loaderView = self.view.viewWithTag(100) else { return }
        loaderView.removeFromSuperview()
    }
    
    func showErrorAlert(message: String) {
        
    }
    
    func showSuccessAlert(message: String) {
        
    }
}
