//
//  TickerDetailConfigurator.swift
//  GBMChallengue
//
//  Created by javier pineda on 13/10/23.
//

protocol TickerDetailConfigurator {
    func configure(_ controller: TickerDetailViewController)
}

class TickerDetailConfiguratorImplementation: TickerDetailConfigurator {
    func configure(_ controller: TickerDetailViewController) {
        // ApiClient
        let apiClient = ApiClient()
        // ApiGateway
        let apiGateway = TickerApiGatewayImplementation(apiClient: apiClient)
        // UseCase
        let useCase = TickerUseCaseImplementation(apiGateway: apiGateway)
        // Router
        let router = TickerDetailRouterImplemenentation(controller: controller)
        // Presenter
        let presenter = TickerListPresenterImplementation(view: controller,
                                                          router: router,
                                                          useCase: useCase)
        controller.presenter = presenter
    }
}
