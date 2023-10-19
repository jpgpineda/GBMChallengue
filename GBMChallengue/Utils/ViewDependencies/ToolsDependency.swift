//
//  ToolsDependency.swift
//  GBMChallengue
//
//  Created by javier pineda on 11/10/23.
//

import Swinject

protocol ToolsDependency {
    var container: Container { get set }
    func makeLoaderViewController() -> LoaderViewController?
}

class ToolsDependencyImplementation: ToolsDependency {
    internal var container: Container
    
    init(container: Container) {
        self.container = container
        registerLoaderViewController()
    }
    
    private func registerLoaderViewController() {
        container.register(LoaderViewController.self) { _ in
            return LoaderViewController()
        }
    }
    
    func makeLoaderViewController() -> LoaderViewController? {
        return container.resolve(LoaderViewController.self)
    }
}
