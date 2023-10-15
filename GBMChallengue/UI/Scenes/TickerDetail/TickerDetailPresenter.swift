//
//  TickerDetailPresenter.swift
//  GBMChallengue
//
//  Created by javier pineda on 13/10/23.
//

import Foundation

protocol TickerDetailView {
    func showFailure(message: String)
    func updateInfo(intraday: TickerIntradayDTO)
}

protocol TickerDetailPresenter {
    var view: TickerDetailView { get set }
    var router: TickerDetailRouter { get set }
    var useCase: TickerUseCase { get set }
    func getTickerDetail(ticker: TickerDetailDTO)
    func dismissView()
}

class TickerDetailPresenterImplementation: TickerDetailPresenter {
    internal var view: TickerDetailView
    internal var router: TickerDetailRouter
    internal var useCase: TickerUseCase
    
    init(view: TickerDetailView,
         router: TickerDetailRouter,
         useCase: TickerUseCase) {
        self.view = view
        self.router = router
        self.useCase = useCase
    }
    
    func getTickerDetail(ticker: TickerDetailDTO) {
        let parameters = TickerIntradayRequest(symbol: ticker.symbol)
        router.showLoader()
        Task {
            let response = await useCase.requesTickerIntraday(parameters: parameters)
            router.dismissLoader()
            switch response {
            case .success(let tickerIntraday):
                DispatchQueue.main.async {
                    self.view.updateInfo(intraday: tickerIntraday)
                }
            case .failure(let error):
                view.showFailure(message: error.localizedDescription)
            }
        }
    }
    
    func dismissView() {
        router.dismissView()
    }
}
