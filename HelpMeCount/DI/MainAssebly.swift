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
        assembleProfileFeature(container: container)
    }

    func loaded(resolver: any Resolver) { }

    private func assembleActionsList(container: Container) {
        container.register(ActionsListPresenter.self) { resolver, view in
            ActionsTabPresenter(view: view)
        }

        container.register(ActionsListInteractor.self) { resolver, presenter in
            let worker = ActionsTabWorker(
                networkLayer: resolver.resolve(NetworkService.self, name: DINames.generatedAPI)!,
                actionsStorage: resolver.resolve(LocalActionsStorage.self)!
            )

            let interactor = ActionsTabInteractor(presenter: presenter, worker: worker)
            interactor.initSubscriptions()
            return interactor
        }
    }

    private func assembleAddAction(container: Container) {
        container.register(AddActionPresenter.self) { resolver, view in
            CreateActionPresenter(view: view)
        }

        container.register(AddActionInteractor.self) { resolver, presenter in
            let worker = CreateActionWorker(
                networkService: resolver.resolve(NetworkService.self, name: DINames.generatedAPI)!,
                localDataStorage: resolver.resolve(LocalActionsStorage.self)!
            )

            return CreateActionInteractor(presenter: presenter, worker: worker)
        }
    }

    private func assembleProfileFeature(container: Container) {
        container.register(ProfilePresenter.self) { resolver, view in
            ProfileTabPresenter(view: view)
        }

        container.register(ProfileInteractor.self) { resolver, presenter in
            let worker = ProfileTabWorker(
                tokenStorage: resolver.resolve(LocalTokensStorage.self)!,
                actionsStorage: resolver.resolve(LocalActionsStorage.self)!
            )
            return ProfileTabInteractor(presenter: presenter, worker: worker)
        }
    }
}
