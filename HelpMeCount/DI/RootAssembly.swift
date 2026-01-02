//
//  RootAssembly.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 29.12.2025.
//

import Foundation
import Swinject

class RootAssembly: Assembly {
    func assemble(container: Swinject.Container) {
        container.register(AppRootPresenter.self) { _, controller in
            RootPresenter(view: controller)
        }

        container.register(AppRootInteractor.self) { resolver, presenter in
            RootInteractor(
                presenter: presenter,
                localService: resolver.resolve(LocalStorageService.self, name: "always_not_logged")!
            )
        }

        container.register(AppRootRouter.self) { resolver in
            RootRouter(resolver: resolver)
        }

        container.register(AppRootConfigurator.self) { resolver in
            AppRootConfigurator(resolver: resolver)
        }
    }
}
