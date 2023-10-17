//
//  TickerListConfigurator.swift
//  GBMChallengue
//
//  Created by javier pineda on 13/10/23.
//

import RealmSwift

protocol TickerListConfigurator {
    func configure(_ controller: TickerListViewController)
}

class TickerListConfiguratorImplementation: TickerListConfigurator {
    func configure(_ controller: TickerListViewController) {
        // ApiClient
        let apiClient = ApiClient()
        let storageContext = StorageContextImplementation(realmDB: try! Realm())
        // ApiGateway
        let apiGateway = TickerApiGatewayImplementation(apiClient: apiClient,
                                                        storageContext: storageContext)
        // UseCase
        let useCase = TickerUseCaseImplementation(apiGateway: apiGateway)
        // Router
        let router = TickerListRouterImplementation(controller: controller)
        // Presenter
        let presenter = TickerListPresenterImplementation(view: controller,
                                                          router: router,
                                                          useCase: useCase)
        
        controller.presenter = presenter
    }
}
