//
//  TickerListRouter.swift
//  GBMChallengue
//
//  Created by javier pineda on 13/10/23.
//

import Foundation

protocol TickerListRouter {
    func showLoader()
    func dismissLoader()
    func presentDrawerMenu()
    func presentTickerDetail(ticker: TickerDetailDTO)
    func presentFavoriteTickers()
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
    
    func dismissView() {
        DispatchQueue.main.async {
            self.controller.navigationController?.dismiss(animated: true)
        }
    }
    
    func presentDrawerMenu() {
        guard let viewController = ModuleManager.homeDependency.makeDrawerMenuViewController(delegate: DrawerTransitionManager()) else { return }
        viewController.signOutObservable.subscribe(onNext: { [weak self] isSignOutRequested in
            guard isSignOutRequested else { return }
            self?.dismissView()
        }).disposed(by: controller.bag)
        controller.present(viewController, animated: true)
    }
    
    func presentTickerDetail(ticker: TickerDetailDTO) {
        guard let viewController = ModuleManager.homeDependency.makeTickerDetailViewController(ticker: ticker) else { return }
        controller.show(viewController, sender: nil)
    }
    
    func presentFavoriteTickers() {
        guard let viewController = ModuleManager.homeDependency.makeFavoriteTickersViewController() else { return }
        controller.show(viewController, sender: nil)
    }
}
