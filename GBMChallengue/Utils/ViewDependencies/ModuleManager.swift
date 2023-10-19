//
//  ModuleManager.swift
//  GBMChallengue
//
//  Created by javier pineda on 11/10/23.
//

import Swinject

class ModuleManager {
    var container = Container()
    static var accessDependency: AccessDependency!
    static var toolsDependency: ToolsDependency!
    static var homeDependency: HomeDependency!
    
    func configure() {
        ModuleManager.accessDependency = AccessDependencyImplementation(container: container)
        ModuleManager.toolsDependency = ToolsDependencyImplementation(container: container)
        ModuleManager.homeDependency = HomeDependencyImplementation(container: container)
    }
}
