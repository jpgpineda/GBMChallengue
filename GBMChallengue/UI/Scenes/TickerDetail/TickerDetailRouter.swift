//
//  TickerDetailRouter.swift
//  GBMChallengue
//
//  Created by javier pineda on 13/10/23.
//

protocol TickerDetailRouter {
    func showLoader()
    func dismissLoader()
    func dismissView()
}

class TickerDetailRouterImplemenentation: TickerDetailRouter {
    private let controller: TickerDetailViewController
    
    init(controller: TickerDetailViewController) {
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
}
