//
//  MainAssebly.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 07.01.2026.
//

import Foundation
import Swinject

class MainAssebly: Assembly {
    func assemble(container: Container) {
        container.register(MainFeatureConfigurator.self) { resolver in
            MainFeatureConfigurator(resolver: resolver)
        }

        container.register(MainFeatureRouter.self) { resolver in
            TabControllerRouter(resolver: resolver)
        }

        assembleActionsList(container: container)
        assembleAddAction(container: container)
    }

    func loaded(resolver: Resolver) {
        resolver.resolve(ActionsListInteractor.self)?.initSubscriptions()
    }

    private func assembleActionsList(container: Container) {
        container.register(ActionsListPresenter.self) { resolver, view in
            ActionsTabPresenter(view: view)
        }

        container.register(ActionsListInteractor.self) { resolver, presenter in
            let network = resolver.resolve(
                NetworkService.self, name: DINames.generatedAPI)!

            return ActionsTabInteractor(
                networkLayer: network,
                presenter: presenter,
                actionsStorage: resolver.resolve(LocalActionsStorage.self)!
            )
        }
    }

    private func assembleAddAction(container: Container) {
        container.register(AddActionPresenter.self) { resolver, view in
            CreateActionPresenter(view: view)
        }

        container.register(AddActionInteractor.self) { resolver, presenter in
            let network = resolver.resolve(
                NetworkService.self, name: DINames.generatedAPI)!

            let localDataStorage = resolver.resolve(LocalActionsStorage.self)!

            return CreateActionInteractor(
                presenter: presenter,
                networkService: network,
                localDataStorage: localDataStorage
            )
        }
    }
}
