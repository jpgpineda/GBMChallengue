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
    var name: String { get set }
    var lastName: String { get set }
    var email: String { get set }
    var password: String { get set }
    func requestSignUp()
    func dismissView()
    func validateData() -> Bool
}

class SignUpPresenterImplementation: SignUpPresenter {
    internal var view: SignUpView
    internal var router: SignUpRouter
    var name: String = .empty
    var lastName: String = .empty
    var email: String = .empty
    var password: String = .empty
    
    init(view: SignUpView,
         router: SignUpRouter) {
        self.view = view
        self.router = router
    }
    
    func requestSignUp() {
        
    }
    
    func dismissView() {
        router.dismissView()
    }
    
    func validateData() -> Bool {
        var isValid = true
        if name.isEmpty {
            isValid = false
        }
        if lastName.isEmpty {
            isValid = false
        }
        if email.isEmpty || !email.isValidEmail() {
            isValid = false
        }
        if password.isEmpty || !password.isPasswordValid() {
            isValid = false
        }
        return isValid
    }
}
