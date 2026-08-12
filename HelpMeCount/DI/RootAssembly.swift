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
        container.register(AppRootPresenter.self) { (_, view: AppRootDisplayLogic) in
            RootPresenter(view: view)
        }

        container.register(AppRootInteractor.self) { resolver, presenter in
            let worker = AppRootTokenWorker(
                tokensStorage: resolver.resolve(LocalTokensStorage.self)!
            )
            return RootInteractor(presenter: presenter, worker: worker)
        }

        container.register(AppRootRouter.self) { resolver in
            RootRouter(resolver: resolver)
        }

        container.register(AppRootConfigurator.self) { resolver in
            AppRootConfigurator(resolver: resolver)
        }
    }
}
