//
//  RestorePasswordPresenter.swift
//  GBMChallengue
//
//  Created by javier pineda on 18/10/23.
//

import Foundation

protocol RestorePasswordView {
    func showSuccess(message: String)
    func showFailure(message: String)
}

protocol RestorePasswordPresenter {
    var view: RestorePasswordView { get set }
    var router: RestorePasswordRouter { get set }
    var useCase: AccessUseCase { get set }
    var email: String { get set }
    func requestRestorePassword()
    func dismissView()
    func validateData() -> Bool
}

class RestorePasswordPresenterImplementation: RestorePasswordPresenter {
    internal var view: RestorePasswordView
    internal var router: RestorePasswordRouter
    internal var useCase: AccessUseCase
    var email: String = .empty
    
    init(view: RestorePasswordView,
         router: RestorePasswordRouter,
         useCase: AccessUseCase) {
        self.view = view
        self.router = router
        self.useCase = useCase
    }
    
    func requestRestorePassword() {
        router.showLoader()
        Task {
            let result = await useCase.sendRestorePasswordLink(email: email)
            switch result {
            case .success(_):
                view.showSuccess(message: .Localized.passwordResetLinkSend)
                DispatchQueue.main.async {
                    self.router.dismissView()
                }
                router.dismissLoader()
            case .failure(let error):
                router.dismissLoader()
                view.showFailure(message: error.customDescription)
            }
        }
    }
    
    func dismissView() {
        router.dismissView()
    }
    
    func validateData() -> Bool {
        var isValid = true
        if email.isEmpty || !email.isValidEmail() {
            isValid = false
        }
        return isValid
    }
}
