//
//  AccessDependency.swift
//  GBMChallengue
//
//  Created by javier pineda on 11/10/23.
//

import Swinject

protocol AccessDependency {
    var container: Container { get set }
    func makeSignInViewController() -> SignInViewController?
    func makeSignUpViewController() -> SignUpViewController?
    func makeRestorePasswordViewController() -> RestorePasswordViewController?
}

class AccessDependencyImplementation: AccessDependency {
    var container: Container
    
    init(container: Container) {
        self.container = container
        registerSignInViewController()
        registerSignUpViewController()
        registerRestorePasswordViewController()
    }
    
    private func registerSignInViewController() {
        container.register(SignInViewController.self) { _ in
            return SignInViewController()
        }
    }
    
    func makeSignInViewController() -> SignInViewController? {
        return container.resolve(SignInViewController.self)
    }
    
    private func registerSignUpViewController() {
        container.register(SignUpViewController.self) { _ in
            return SignUpViewController()
        }
    }
    
    func makeSignUpViewController() -> SignUpViewController? {
        return container.resolve(SignUpViewController.self)
    }
    
    private func registerRestorePasswordViewController() {
        container.register(RestorePasswordViewController.self) { _ in
            return RestorePasswordViewController()
        }
    }
    
    func makeRestorePasswordViewController() -> RestorePasswordViewController? {
        return container.resolve(RestorePasswordViewController.self)
    }
}
