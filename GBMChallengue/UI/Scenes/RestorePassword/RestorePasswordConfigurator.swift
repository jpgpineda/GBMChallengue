//
//  RestorePasswordImplementation.swift
//  GBMChallengue
//
//  Created by javier pineda on 18/10/23.
//

import FirebaseAuth
import FirebaseFirestore

protocol RestorePasswordConfigurator {
    func configure(_ controller: RestorePasswordViewController)
}

class RestorePasswordConfiguratorImplementation: RestorePasswordConfigurator {
    func configure(_ controller: RestorePasswordViewController) {
        // ApiClient
        let auth = Auth.auth()
        let firebaseDB = Firestore.firestore()
        // ApiGateway
        let apiGateway = AccessApiGatewayImplementation(auth: auth, firebaseDB: firebaseDB)
        // UseCase
        let useCase = AccessUseCaseImplementation(apiGateway: apiGateway)
        // Router
        let router = RestorePasswordRouterImplementation(controller: controller)
        // Presenter
        let presenter = RestorePasswordPresenterImplementation(view: controller,
                                                               router: router,
                                                               useCase: useCase)
        controller.presenter = presenter
    }
}
