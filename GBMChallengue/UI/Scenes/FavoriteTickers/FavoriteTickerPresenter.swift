//
//  FavoriteTickerPresenter.swift
//  GBMChallengue
//
//  Created by javier pineda on 16/10/23.
//

protocol FavoriteTickerView {
    func showSuccess(message: String)
    func showFailure(message: String)
    func updateTickerList(data: [TickerDetailDTO])
}

protocol FavoriteTickerPresenter {
    var view: FavoriteTickerView { get set }
    var router: FavoriteTickersRouter { get set }
    var useCase: TickerUseCase { get set }
    func getFavorites()
    func deleteTicker(ticker: TickerDetailDTO)
    func presentDeletionAlert(ticker: TickerDetailDTO)
    func presentTickerDetail(ticker: TickerDetailDTO)
    func dismissView()
}

class FavoriteTickerPresenterImplementation: FavoriteTickerPresenter {
    internal var view: FavoriteTickerView
    internal var router: FavoriteTickersRouter
    internal var useCase: TickerUseCase
    
    init(view: FavoriteTickerView,
         router: FavoriteTickersRouter,
         useCase: TickerUseCase) {
        self.view = view
        self.router = router
        self.useCase = useCase
    }
    
    func getFavorites() {
        guard let tickers = useCase.getFavoriteTickers() else {
            view.updateTickerList(data: [])
            return
        }
        view.updateTickerList(data: tickers)
    }
    
    func deleteTicker(ticker: TickerDetailDTO) {
        router.showLoader()
        useCase.deleteTicker(ticker: ticker) { [weak self] result in
            self?.router.dismissLoader()
            switch result {
            case .success(_):
                self?.view.showSuccess(message: .Localized.tickerDeleted)
                delay(.fast) {
                    self?.getFavorites()
                }
            case .failure(let error):
                self?.view.showFailure(message: error.customDescription)
            }
        }
    }
    
    func presentDeletionAlert(ticker: TickerDetailDTO) {
        router.presentDeletionAlert(ticker: ticker)
    }
    
    func presentTickerDetail(ticker: TickerDetailDTO) {
        router.presentTickerDetail(ticker: ticker)
    }
    
    func dismissView() {
        router.dismissView()
    }
}
