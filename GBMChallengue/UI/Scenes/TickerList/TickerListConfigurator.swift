//
//  TickerListConfigurator.swift
//  GBMChallengue
//
//  Created by javier pineda on 13/10/23.
//

protocol TickerListConfigurator {
    func configure(_ controller: TickerListViewController)
}

class TickerListConfiguratorImplementation: TickerListConfigurator {
    func configure(_ controller: TickerListViewController) {
        // ApiClient
        let apiClient = ApiClient()
        // ApiGateway
        let apiGateway = TickerApiGatewayImplementation(apiClient: apiClient)
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
