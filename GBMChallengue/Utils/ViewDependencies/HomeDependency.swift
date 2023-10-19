//
//  HomeDependency.swift
//  GBMChallengue
//
//  Created by javier pineda on 12/10/23.
//

import Swinject

protocol HomeDependency {
    var container: Container { get set }
    func makeDrawerMenuViewController(delegate: DrawerTransitionManager) -> DrawerMenuViewController?
    func makeTickerListViewController() -> TickerListViewController?
    func makeTickerDetailViewController(ticker: TickerDetailDTO) -> TickerDetailViewController?
    func makeFavoriteTickersViewController() -> FavoriteTickersViewController?
}

class HomeDependencyImplementation: HomeDependency {
    internal var container: Container
    
    init(container: Container) {
        self.container = container
        registerDrawerMenuViewController()
        registerTickerListViewController()
        registerTickerDetailViewController()
        registerFavoriteTickerViewController()
    }
    
    private func registerDrawerMenuViewController() {
        container.register(DrawerMenuViewController.self) { _ in
            return DrawerMenuViewController()
        }
    }
    
    func makeDrawerMenuViewController(delegate: DrawerTransitionManager) -> DrawerMenuViewController? {
        guard let viewController = container.resolve(DrawerMenuViewController.self) else { return nil }
        viewController.transitionManager = delegate
        viewController.transitioningDelegate = delegate
        viewController.modalPresentationStyle = .custom
        return viewController
    }
    
    private func registerTickerListViewController() {
        container.register(TickerListViewController.self) { _ in
            return TickerListViewController()
        }
    }
    
    func makeTickerListViewController() -> TickerListViewController? {
        container.resolve(TickerListViewController.self)
    }
    
    func registerTickerDetailViewController() {
        container.register(TickerDetailViewController.self) { _ in
            return TickerDetailViewController()
        }
    }
    
    func makeTickerDetailViewController(ticker: TickerDetailDTO) -> TickerDetailViewController? {
        guard let viewController = container.resolve(TickerDetailViewController.self) else { return nil }
        viewController.ticker = ticker
        return viewController
    }
    
    private func registerFavoriteTickerViewController() {
        container.register(FavoriteTickersViewController.self) { _ in
            return FavoriteTickersViewController()
        }
    }
    
    func makeFavoriteTickersViewController() -> FavoriteTickersViewController? {
        return container.resolve(FavoriteTickersViewController.self)
    }
}


