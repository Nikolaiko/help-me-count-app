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

        assembleAddAction(container: container)
    }

    private func assembleAddAction(container: Container) {
        container.register(AddActionPresenter.self) { resolver, view in
            CreateActionPresenter(view: view)
        }

        container.register(AddActionInteractor.self) { resolver, presenter in
            let network = resolver.resolve(
                NetworkService.self, name: DINames.generatedAPI)!

            return CreateActionInteractor(
                presenter: presenter,
                networkService: network
            )
        }
    }
}
