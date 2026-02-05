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

        container.register(AppAuthorizedRouter.self) { resolver, controller in
            AppAuthorizedRouter(resolver: resolver, parentController: controller)
        }

        assembleActionsList(container: container)
        assembleCreateAction(container: container)
    }

    func loaded(resolver: any Resolver) { }

    private func assembleCreateAction(container: Container) {

        container.register(AddActionInteractor.self) { resolver, presenter in
            let networkService = resolver.resolve(
                NetworkService.self,
                name: DIName.generatedNetworkLayer)!

            let localService = resolver.resolve(
                LocalDataStorage.self,
                name: DIName.swiftDataStorage)!

            return AddActionInteractor(
                presenter: presenter,
                networkService: networkService,
                localStorage: localService
            )
        }

        container.register(AddActionPresenter.self) { _, controller in
            AddActionPresenter(view: controller)
        }
    }

    private func assembleActionsList(container: Container) {
        container.register(ActionsInteractor.self) { resolver, presenter in
            let networkService = resolver.resolve(
                NetworkService.self,
                name: DIName.generatedNetworkLayer)!

            let localService = resolver.resolve(
                LocalDataStorage.self,
                name: DIName.swiftDataStorage)!

            return ActionsInteractor(
                presenter: presenter,
                networkService: networkService,
                localStorage: localService
            )
        }

        container.register(ActionsPresenter.self) { _, controller in
            ActionsPresenter(view: controller)
        }
    }
}

