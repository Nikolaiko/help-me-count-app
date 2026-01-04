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

        container.register(ActionsInteractor.self) { resolver, presenter in
            ActionsInteractor(
                presenter: presenter,
                networkService: resolver.resolve(NetworkService.self)!,
                localStorage: resolver.resolve(LocalDataStorage.self)!
            )
        }

        container.register(ActionsPresenter.self) { _, controller in
            ActionsPresenter(view: controller)
        }
    }

    func loaded(resolver: any Resolver) {
        
    }
}

