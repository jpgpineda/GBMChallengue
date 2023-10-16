//
//  DrawerMenuConfigurator.swift
//  GBMChallengue
//
//  Created by javier pineda on 16/10/23.
//

import FirebaseAuth
import FirebaseFirestore

protocol DrawerMenuConfigurator {
    func configure(_ controller: DrawerMenuViewController)
}

class DrawerMenuConfiguratorImplementation: DrawerMenuConfigurator {
    func configure(_ controller: DrawerMenuViewController) {
        // ApiClient
        let auth = Auth.auth()
        let firebaseDB = Firestore.firestore()
        // ApiGateway
        let apiGateway = UserApiGatewayImplementation(auth: auth, firebaseFB: firebaseDB)
        let accessApiGateway = AccessApiGatewayImplementation(auth: auth,
                                                              firebaseDB: firebaseDB)
        // UseCase
        let useCase = UserUseCaseImplementation(apiGateway: apiGateway)
        let accessUseCase = AccessUseCaseImplementation(apiGateway: accessApiGateway)
        // Router
        let router = DrawerMenuRouterImplementation(controller: controller)
        // Presenter
        let presenter = DrawerMenuPresenterImplementation(view: controller,
                                                          router: router,
                                                          useCase: useCase,
                                                          accessUseCase: accessUseCase)
        controller.presenter = presenter
    }
}
