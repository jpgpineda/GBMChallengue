//
//  TickerDetailConfigurator.swift
//  GBMChallengue
//
//  Created by javier pineda on 13/10/23.
//

import RealmSwift

protocol TickerDetailConfigurator {
    func configure(_ controller: TickerDetailViewController)
}

class TickerDetailConfiguratorImplementation: TickerDetailConfigurator {
    func configure(_ controller: TickerDetailViewController) {
        // ApiClient
        let apiClient = ApiClient()
        let storageContext = StorageContextImplementation(realmDB: try! Realm())
        // ApiGateway
        let apiGateway = TickerApiGatewayImplementation(apiClient: apiClient,
                                                        storageContext: storageContext)
        // UseCase
        let useCase = TickerUseCaseImplementation(apiGateway: apiGateway)
        // Router
        let router = TickerDetailRouterImplemenentation(controller: controller)
        // Presenter
        let presenter = TickerDetailPresenterImplementation(view: controller,
                                                            router: router,
                                                            useCase: useCase)
        controller.presenter = presenter
    }
}
