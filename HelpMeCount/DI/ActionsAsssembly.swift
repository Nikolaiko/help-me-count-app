//
//  ActionsAsssembly.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 28.12.2025.
//

import Foundation
import Swinject

class ActionsAsssembly: Assembly {
    func assemble(container: Container) {
        container.register(ActionsConfigurator.self) { resolver, controller in
            ActionsConfigurator(resolver: resolver, parentController: controller)
        }

        container.register(ActionsInteractor.self) { _ in
            ActionsInteractor()
        }
    }

    func loaded(resolver: any Resolver) {
        
    }
}

