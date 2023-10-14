//
//  SignInRouter.swift
//  GBMChallengue
//
//  Created by javier pineda on 11/10/23.
//

import UIKit

protocol SignInRouter {
    func showLoader()
    func dismissLoader()
    func presentRestorePassword()
    func presentTickerList()
    func presentSignUp()
    func dismissScreen()
}

class SignInRouterImplementation: SignInRouter {
    private let controller: SignInViewController
    
    init(controller: SignInViewController) {
        self.controller = controller
    }
    
    func showLoader() {
        controller.showLoader()
    }
    
    func dismissLoader() {
        controller.dismissLoader()
    }
    
    func presentRestorePassword() {
        
    }
    
    func presentTickerList() {
        guard let viewController = ModuleManager.homeDependency.makeTickerListViewController() else { return }
        DispatchQueue.main.async {
            let navigationController = UINavigationController(rootViewController: viewController)
            navigationController.setupPresentation()
            self.controller.present(navigationController, animated: true)
        }
    }
    
    func presentSignUp() {
        guard let viewController = ModuleManager.accessDependency.makeSignUpViewController() else { return }
        controller.show(viewController, sender: nil)
    }
    
    func dismissScreen() {
        controller.navigationController?.popViewController(animated: true)
    }
}
