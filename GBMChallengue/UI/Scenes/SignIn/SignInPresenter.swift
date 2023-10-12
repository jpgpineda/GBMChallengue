//
//  SignInPresenter.swift
//  GBMChallengue
//
//  Created by javier pineda on 11/10/23.
//

protocol SignInView {
    func showFailure(message: String)
    func showSuccess(message: String)
}

protocol SignInPresenter {
    var view: SignInView { get set }
    var router: SignInRouter { get set }
    var email: String { get set }
    var password: String { get set }
    func requestSignIn()
    func presentRestorePassword()
    func presentSignUp()
    func dismissScreen()
    func validateData() -> Bool
}

class SignInPresenterImplementation: SignInPresenter {
    internal var view: SignInView
    internal var router: SignInRouter
    var email: String = .empty
    var password: String = .empty
    
    init(view: SignInView,
         router: SignInRouter) {
        self.view = view
        self.router = router
    }
    
    func requestSignIn() {
        
    }
    
    func presentRestorePassword() {
        
    }
    
    func presentSignUp() {
        router.presentSignUp()
    }
    
    func dismissScreen() {
        router.dismissScreen()
    }
    
    func validateData() -> Bool {
        var isValid = true
        if email.isEmpty || !email.isValidEmail() {
            isValid = true
        }
        if password.isEmpty || !password.isPasswordValid() {
            isValid = false
        }
        return isValid
    }
}
