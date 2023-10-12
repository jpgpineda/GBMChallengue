//
//  SignInConfigurator.swift
//  GBMChallengue
//
//  Created by javier pineda on 11/10/23.
//

protocol SignInConfigurator {
    func configure(controller: SignInViewController)
}

class SignInConfiguratorImplementation: SignInConfigurator {
    func configure(controller: SignInViewController) {
        // ApiClient
        
        // ApiClient
        
        // UseCase
        
        // Router
        let router = SignInRouterImplementation(controller: controller)
        
        // Presenter
        let presenter = SignInPresenterImplementation(view: controller,
                                                      router: router)
        
        controller.presenter = presenter
    }
}
