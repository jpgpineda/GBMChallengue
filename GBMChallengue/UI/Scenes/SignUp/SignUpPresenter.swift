//
//  SignUpPresenter.swift
//  GBMChallengue
//
//  Created by javier pineda on 12/10/23.
//

import Foundation

protocol SignUpView {
    func showFailure(message: String)
    func showSuccess(message: String)
}

protocol SignUpPresenter {
    var view: SignUpView { get set }
    var router: SignUpRouter { get set }
    var useCase: AccessUseCase { get set }
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
    internal var useCase: AccessUseCase
    var name: String = .empty
    var lastName: String = .empty
    var email: String = .empty
    var password: String = .empty
    
    init(view: SignUpView,
         router: SignUpRouter,
         useCase: AccessUseCase) {
        self.view = view
        self.router = router
        self.useCase = useCase
    }
    
    func requestSignUp() {
        let parameters = SignUpRequest(name: name,
                                       lastName: lastName,
                                       email: email,
                                       password: password)
        router.showLoader()
        Task(priority: .background) {
            let response = await useCase.createUser(parameters: parameters)
            router.dismissLoader()
            switch response {
            case .success(_):
                self.view.showSuccess(message: .Localized.accountCreated)
                self.router.dismissView()
            case .failure(let error):
                self.view.showFailure(message: error.localizedDescription)
            }
        }
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
