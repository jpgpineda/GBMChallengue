//
//  TickerDetailPresenter.swift
//  GBMChallengue
//
//  Created by javier pineda on 13/10/23.
//

protocol TickerDetailView {
    func showFailure(message: String)
}

protocol TickerDetailPresenter {
    var view: TickerDetailView { get set }
    var router: TickerDetailRouter { get set }
    var useCase: TickerUseCase { get set }
    func getTickerDetail(ticker: TickerDetailDTO)
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
        
    }
}
