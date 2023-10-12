//
//  SignUpRouter.swift
//  GBMChallengue
//
//  Created by javier pineda on 12/10/23.
//

protocol SignUpRouter {
    func dismissView()
    func showLoader()
    func dismissLoader()
    func presentHome()
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
    
    func presentHome() {
        
    }
}
