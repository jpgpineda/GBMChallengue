//
//  SignUpRouter.swift
//  GBMChallengue
//
//  Created by javier pineda on 12/10/23.
//

import UIKit

protocol SignUpRouter {
    func dismissView()
    func showLoader()
    func dismissLoader()
    func presentTickerList()
}

class SignUpRouterImplementation: SignUpRouter {
    private let controller: SignUpViewController
    
    init(controller: SignUpViewController) {
        self.controller = controller
    }
    
    func dismissView() {
        controller.navigationController?.popViewController(animated: true)
    }
    
    func showLoader() {
        controller.showLoader()
    }
    
    func dismissLoader() {
        controller.dismissLoader()
    }
    
    func presentTickerList() {
        guard let viewController = ModuleManager.homeDependency.makeTickerListViewController() else { return }
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.setupPresentation()
        controller.present(navigationController, animated: true)
    }
}
