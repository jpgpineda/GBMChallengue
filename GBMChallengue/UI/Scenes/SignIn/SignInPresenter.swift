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
    var useCase: AccessUseCase { get set }
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
    internal var useCase: AccessUseCase
    var email: String = .empty
    var password: String = .empty
    
    init(view: SignInView,
         router: SignInRouter,
         useCase: AccessUseCase) {
        self.view = view
        self.router = router
        self.useCase = useCase
    }
    
    func requestSignIn() {
        let parameters = SignInRequest(email: email, password: password)
        router.showLoader()
        Task(priority: .background) {
            let response = await useCase.requestSignIn(parameters: parameters)
            switch response {
            case .success(_):
                router.presentTickerList()
            case .failure(let error):
                router.dismissLoader()
                view.showFailure(message: error.localizedDescription)
            }
        }
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
