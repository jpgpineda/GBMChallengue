//
//  FavoriteTickersConfigurator.swift
//  GBMChallengue
//
//  Created by javier pineda on 16/10/23.
//

import RealmSwift

protocol FavoriteTickersConfigurator {
    func configure(_ controller: FavoriteTickersViewController)
}

class FavoriteTickersConfiguratorImplementation: FavoriteTickersConfigurator {
    func configure(_ controller: FavoriteTickersViewController) {
        // ApiClient
        let apiClient = ApiClient()
        let storageContext = StorageContextImplementation(realmDB: try! Realm())
        // ApiGateway
        let apiGateway = TickerApiGatewayImplementation(apiClient: apiClient,
                                                        storageContext: storageContext)
        // UseCase
        let useCase = TickerUseCaseImplementation(apiGateway: apiGateway)
        // Router
        let router = FavoriteTickersRouterImplementation(controller: controller)
        // Presenter
        let presenter = FavoriteTickerPresenterImplementation(view: controller,
                                                              router: router,
                                                              useCase: useCase)
        controller.presenter = presenter
    }
}
