//
//  TickerListRouter.swift
//  GBMChallengue
//
//  Created by javier pineda on 13/10/23.
//

protocol TickerListRouter {
    func showLoader()
    func dismissLoader()
    func presentDrawerMenu()
}

class TickerListRouterImplementation: TickerListRouter {
    private let controller: TickerListViewController
    
    init(controller: TickerListViewController) {
        self.controller = controller
    }
    
    func showLoader() {
        controller.showLoader()
    }
    
    func dismissLoader() {
        controller.dismissLoader()
    }
    
    func presentDrawerMenu() {
        guard let viewController = ModuleManager.homeDependency.makeDrawerMenuViewController() else { return }
        controller.present(viewController, animated: true)
    }
}
