//
//  SignInPresenter.swift
//  GBMChallengue
//
//  Created by javier pineda on 11/10/23.
//

protocol SignInView {
    
}

protocol SignInPresenter {
    var view: SignInView { get set }
    var router: SignInRouter { get set }
    func requestSignIn(email: String, password: String)
    func presentRestorePassword()
    func presentSignUp()
    func dismissScreen()
}

class SignInPresenterImplementation: SignInPresenter {
    internal var view: SignInView
    internal var router: SignInRouter
    
    init(view: SignInView,
         router: SignInRouter) {
        self.view = view
        self.router = router
    }
    
    func requestSignIn(email: String, password: String) {
        
    }
    
    func presentRestorePassword() {
        
    }
    
    func presentSignUp() {
        router.presentSignUp()
    }
    
    func dismissScreen() {
        router.dismissScreen()
    }
}
