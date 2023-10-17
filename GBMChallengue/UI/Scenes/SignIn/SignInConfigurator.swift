//
//  SignInConfigurator.swift
//  GBMChallengue
//
//  Created by javier pineda on 11/10/23.
//

import FirebaseAuth
import FirebaseFirestore

protocol SignInConfigurator {
    func configure(controller: SignInViewController)
}

class SignInConfiguratorImplementation: SignInConfigurator {
    func configure(controller: SignInViewController) {
        // ApiClient
        let auth = Auth.auth()
        let firebaseDB = Firestore.firestore()
        // ApiGateway
        let apiGateway = AccessApiGatewayImplementation(auth: auth, firebaseDB: firebaseDB)
        let userApiGateway = UserApiGatewayImplementation(auth: auth, firebaseFB: firebaseDB)
        // UseCase
        let useCase = AccessUseCaseImplementation(apiGateway: apiGateway)
        let userUseCase = UserUseCaseImplementation(apiGateway: userApiGateway)
        // Router
        let router = SignInRouterImplementation(controller: controller)
        
        // Presenter
        let presenter = SignInPresenterImplementation(view: controller,
                                                      router: router,
                                                      useCase: useCase,
                                                      userUseCase: userUseCase)
        
        controller.presenter = presenter
    }
}
