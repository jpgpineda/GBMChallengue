//
//  SignUpConfigurator.swift
//  GBMChallengue
//
//  Created by javier pineda on 12/10/23.
//

import FirebaseAuth
import FirebaseFirestore

protocol SignUpConfigurator {
    func configure(_ controller: SignUpViewController)
}

class SignUpConfiguratorImplementation: SignUpConfigurator {
    func configure(_ controller: SignUpViewController) {
        // ApiClient
        let auth = Auth.auth()
        let firebaseDB = Firestore.firestore()
        // ApiGateway
        let apiGateWay = AccessApiGatewayImplementation(auth: auth, firebaseDB: firebaseDB)
        // UseCase
        let useCase = AccessUseCaseImplementation(apiGateway: apiGateWay)
        // Router
        let router = SignUpRouterImplementation(controller: controller)
        // Presenter
        let presenter = SignUpPresenterImplementation(view: controller,
                                                      router: router,
                                                      useCase: useCase)
        
        controller.presenter = presenter
    }
}
