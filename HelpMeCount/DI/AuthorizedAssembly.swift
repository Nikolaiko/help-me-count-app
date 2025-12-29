//
//  AuthorizedAssembly.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 29.12.2025.
//

import Swinject
import Foundation

class AuthorizedAssembly: Assembly {
    func assemble(container: Swinject.Container) {
        container.register(AuthorizedControllerConfigurator.self) { resolver, controller in
            AuthorizedControllerConfigurator(resolver: resolver, parentController: controller)
        }
    }
}

