//
//  SignInRouter.swift
//  GBMChallengue
//
//  Created by javier pineda on 11/10/23.
//

protocol SignInRouter {
    func showLoader()
    func dismissLoader()
    func presentRestorePassword()
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
    
    func presentSignUp() {
        guard let viewController = ModuleManager.accessDependency.makeSignUpViewController() else { return }
        controller.show(viewController, sender: nil)
    }
    
    func dismissScreen() {
        controller.navigationController?.popViewController(animated: true)
    }
}
