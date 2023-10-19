//
//  TickerListPresenter.swift
//  GBMChallengue
//
//  Created by javier pineda on 13/10/23.
//

import Foundation

protocol TickerListView {
    func showFailure(message: String)
    func updateTickerList(tickers: [TickerDetailDTO])
}

protocol TickerListPresenter {
    var view: TickerListView { get set }
    var router: TickerListRouter { get set }
    var useCase: TickerUseCase { get set }
    var isPaginating: Bool { get set }
    func requestTickers(pagination: Bool, offSet: Int?)
    func presentTickerDetail(ticker: TickerDetailDTO)
    func presentFavoriteTickers()
    func presentDrawerMenu()
}

class TickerListPresenterImplementation: TickerListPresenter {
    internal var view: TickerListView
    internal var router: TickerListRouter
    internal var useCase: TickerUseCase
    var tickers: [TickerDetailDTO] = [TickerDetailDTO]()
    var isPaginating: Bool = false
    
    init(view: TickerListView,
         router: TickerListRouter,
         useCase: TickerUseCase) {
        self.view = view
        self.router = router
        self.useCase = useCase
    }
    
    func requestTickers(pagination: Bool, offSet: Int?) {
        if pagination {
            isPaginating = true
        }
        router.showLoader()
        let parameters = TickerRequest(offSet: offSet)
        Task {
            let response = await useCase.requestTicker(parameters: parameters)
            router.dismissLoader()
            switch response {
            case .success(let tickers):
                self.tickers = tickers.tickers
                DispatchQueue.main.async {
                    self.view.updateTickerList(tickers: self.tickers)
                    if pagination {
                        self.isPaginating = false
                    }
                }
            case .failure(let error):
                view.showFailure(message: error.localizedDescription)
                isPaginating = false
            }
        }
    }
    
    func presentTickerDetail(ticker: TickerDetailDTO) {
        router.presentTickerDetail(ticker: ticker)
    }
    
    func presentFavoriteTickers()  {
        router.presentFavoriteTickers()
    }
    
    func presentDrawerMenu() {
        router.presentDrawerMenu()
    }
}
