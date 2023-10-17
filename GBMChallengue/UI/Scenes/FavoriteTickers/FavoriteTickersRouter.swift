//
//  FavoriteTickersRouter.swift
//  GBMChallengue
//
//  Created by javier pineda on 16/10/23.
//

protocol FavoriteTickersRouter {
    func showLoader()
    func dismissLoader()
    func dismissView()
    func presentTickerDetail(ticker: TickerDetailDTO)
    func presentDeletionAlert(ticker: TickerDetailDTO)
}

class FavoriteTickersRouterImplementation: FavoriteTickersRouter {
    private let controller: FavoriteTickersViewController
    
    init(controller: FavoriteTickersViewController) {
        self.controller = controller
    }
    
    func showLoader() {
        controller.showLoader()
    }
    
    func dismissLoader() {
        controller.dismissLoader()
    }
    
    func dismissView() {
        controller.navigationController?.popViewController(animated: true)
    }
    
    func presentTickerDetail(ticker: TickerDetailDTO) {
        guard let viewController = ModuleManager.homeDependency.makeTickerDetailViewController(ticker: ticker) else { return }
        controller.show(viewController, sender: nil)
    }
    
    func presentDeletionAlert(ticker: TickerDetailDTO) {
        controller.showConfimation(title: .Localized.caution,
                                   message: .Localized.tickerEliminationMessage,
                                   cancel: .Localized.cancel,
                                   confirm: .Localized.confirm) {
            self.controller.presenter.deleteTicker(ticker: ticker)
        }
    }
}
