//
//  SignUpPresenter.swift
//  GBMChallengue
//
//  Created by javier pineda on 12/10/23.
//

protocol SignUpView {
    func showFailure(message: String)
    func showSuccess(message: String)
}

protocol SignUpPresenter {
    var view: SignUpView { get set }
    var router: SignUpRouter { get set }
    func requestSignUp(name: String,
                       lastNames: String,
                       email: String,
                       password: String)
    func dismissView()
}

class SignUpPresenterImplementation: SignUpPresenter {
    internal var view: SignUpView
    internal var router: SignUpRouter
    
    init(view: SignUpView,
         router: SignUpRouter) {
        self.view = view
        self.router = router
    }
    
    func requestSignUp(name: String,
                       lastNames: String,
                       email: String,
                       password: String) {
        
    }
    
    func dismissView() {
        router.dismissView()
    }
}
