//
//  RestorePasswordRouter.swift
//  GBMChallengue
//
//  Created by javier pineda on 18/10/23.
//

protocol RestorePasswordRouter {
    func showLoader()
    func dismissLoader()
    func dismissView()
}

class RestorePasswordRouterImplementation: RestorePasswordRouter {
    private let controller: RestorePasswordViewController
    
    init(controller: RestorePasswordViewController) {
        self.controller = controller
    }
    
    func showLoader() {
        controller.showLoader()
    }
    
    func dismissLoader() {
        controller.dismissLoader()
    }
    
    func dismissView() {
        controller.navigationController?.popViewController(animated: true)
    }
}
