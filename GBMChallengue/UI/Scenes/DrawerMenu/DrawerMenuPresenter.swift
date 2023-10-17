//
//  DrawerMenuPresenter.swift
//  GBMChallengue
//
//  Created by javier pineda on 16/10/23.
//

import Foundation

protocol DrawerMenuView {
    func notifySignOutRequested()
    func updateUserInfo(data: UserDTO)
    func showFailure(message: String)
}

protocol DrawerMenuPresenter {
    var view: DrawerMenuView { get set }
    var router: DrawerMenuRouter { get set }
    var useCase: UserUseCase { get set }
    var accessUseCase: AccessUseCase { get set }
    func fetchUserInfo()
    func requestSignOut()
    func openAppSettings()
    func showSignOutConfirmation()
}

class DrawerMenuPresenterImplementation: DrawerMenuPresenter {
    internal var view: DrawerMenuView
    internal var router: DrawerMenuRouter
    internal var useCase: UserUseCase
    internal var accessUseCase: AccessUseCase
    
    init(view: DrawerMenuView,
         router: DrawerMenuRouter,
         useCase: UserUseCase,
         accessUseCase: AccessUseCase) {
        self.view = view
        self.router = router
        self.useCase = useCase
        self.accessUseCase = accessUseCase
    }
    
    func fetchUserInfo() {
        router.showLoader()
        Task {
            let response = await useCase.fetchUserInfo()
            router.dismissLoader()
            switch response {
            case .success(let userData):
                DispatchQueue.main.async {
                    self.view.updateUserInfo(data: userData)
                }
            case .failure(let apiError):
                view.showFailure(message: apiError.customDescription)
            }
        }
    }
    
    func requestSignOut() {
        router.showLoader()
        Task {
            let response = await accessUseCase.requestSignOut()
            router.dismissLoader()
            switch response {
            case .success(_):
                DispatchQueue.main.async {
                    self.router.dismissView()
                }
                view.notifySignOutRequested()
            case .failure(let apiError):
                view.showFailure(message: apiError.customDescription)
            }
        }
    }
    
    func openAppSettings() {
        router.openAppSettings()
    }
    
    func showSignOutConfirmation() {
        router.showSignOutConfirmation()
    }
}
