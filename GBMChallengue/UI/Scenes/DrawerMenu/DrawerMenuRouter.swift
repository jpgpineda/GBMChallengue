//
//  DrawerMenuRouter.swift
//  GBMChallengue
//
//  Created by javier pineda on 16/10/23.
//

import UIKit

protocol DrawerMenuRouter {
    func showLoader()
    func dismissLoader()
    func dismissView()
    func openAppSettings()
    func showSignOutConfirmation()
}

class DrawerMenuRouterImplementation: DrawerMenuRouter {
    private let controller: DrawerMenuViewController
    
    init(controller: DrawerMenuViewController) {
        self.controller = controller
    }
    
    func showLoader() {
        controller.showLoader()
    }
    
    func dismissLoader() {
        controller.dismissLoader()
    }
    
    func dismissView() {
        controller.dismiss(animated: true)
    }
    
    func openAppSettings() {
        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else { return }
        if UIApplication.shared.canOpenURL(settingsUrl) {
            UIApplication.shared.open(settingsUrl)
        }
    }
    
    func showSignOutConfirmation() {
        controller.showConfimation(title: .Localized.caution,
                                   message: .Localized.signOutConfirmation,
                                   cancel: .Localized.cancel,
                                   confirm: .Localized.confirm) {
            self.controller.presenter.requestSignOut()
        }
    }
}