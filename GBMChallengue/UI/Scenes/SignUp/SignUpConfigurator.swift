//
//  SignUpConfigurator.swift
//  GBMChallengue
//
//  Created by javier pineda on 12/10/23.
//

protocol SignUpConfigurator {
    func configure(_ controller: SignUpViewController)
}

class SignUpConfiguratorImplementation: SignUpConfigurator {
    func configure(_ controller: SignUpViewController) {
        // ApiClient
        
        // ApiGateway
        
        // UseCase
        
        // Router
        let router = SignUpRouterImplementation(controller: controller)
        // Presenter
        let presenter = SignUpPresenterImplementation(view: controller,
                                                      router: router)
        
        controller.presenter = presenter
    }
}
