//
//  SignInPresenter.swift
//  GBMChallengue
//
//  Created by javier pineda on 11/10/23.
//

import LocalAuthentication

protocol SignInView {
    func showFailure(message: String)
    func showSuccess(message: String)
}

protocol SignInPresenter {
    var view: SignInView { get set }
    var router: SignInRouter { get set }
    var useCase: AccessUseCase { get set }
    var userUseCase: UserUseCase { get set }
    var email: String { get set }
    var password: String { get set }
    var isLocalAuthOn: Bool { get set }
    func requestSignIn()
    func requestBiometricLogin()
    func presentRestorePassword()
    func presentSignUp()
    func getLocalAuthPref() -> Bool?
    func getLastSignUser() -> String
    func doSignIn()
    func dismissScreen()
    func validateData() -> Bool
}

class SignInPresenterImplementation: SignInPresenter {
    internal var view: SignInView
    internal var router: SignInRouter
    internal var useCase: AccessUseCase
    internal var userUseCase: UserUseCase
    var email: String = .empty
    var password: String = .empty
    var isLocalAuthOn: Bool = false
    
    init(view: SignInView,
         router: SignInRouter,
         useCase: AccessUseCase,
         userUseCase: UserUseCase) {
        self.view = view
        self.router = router
        self.useCase = useCase
        self.userUseCase = userUseCase
    }
    
    func requestSignIn() {
        let parameters = SignInRequest(email: email, password: password)
        router.showLoader()
        Task(priority: .background) {
            let response = await useCase.requestSignIn(parameters: parameters)
            switch response {
            case .success(_):
                router.presentTickerList()
                userUseCase.saveLastSignedUser(email: email)
                if isLocalAuthOn {
                    useCase.saveLocalAuthPref(isEnabled: userUseCase.canEncryptCredentials(email: email, password: password))
                }
            case .failure(let error):
                router.dismissLoader()
                view.showFailure(message: error.localizedDescription)
            }
        }
    }
    
    func requestBiometricLogin() {
        guard let localPref = useCase.getLocalAuthPref() else { return }
        if localPref {
            guard let credentials = userUseCase.canRetrieveEncryptedCrendentials(email: userUseCase.getLastSignedUser()) else { return }
            email = credentials.email
            password = credentials.password
            requestLocalAuth()
        }
    }
    
    func doSignIn() {
        if isLocalAuthOn {
            requestLocalAuth()
        } else {
            requestSignIn()
        }
    }
    
    func getLocalAuthPref() -> Bool? {
        guard let preference = useCase.getLocalAuthPref() else { return nil }
        isLocalAuthOn = preference
        return preference
    }
    
    func getLastSignUser() -> String {
        let email = userUseCase.getLastSignedUser()
        self.email = email
        return email
    }
    
    func requestLocalAuth() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: .Localized.biometricDescription) { [weak self] success, _ in
                DispatchQueue.main.async {
                    if success {
                        self?.requestSignIn()
                    } else {
                        self?.view.showFailure(message: .Localized.invalidBiometric)
                    }
                }
            }
        } else {
            view.showFailure(message: .Localized.biometricUnavailable)
        }
    }
    
    func presentRestorePassword() {
        router.presentRestorePassword()
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
