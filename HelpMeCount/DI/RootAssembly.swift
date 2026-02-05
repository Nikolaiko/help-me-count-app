//
//  RootAssembly.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 27.12.2025.
//

import Foundation
import Swinject

class RootAssembly: Assembly {
    func assemble(container: Swinject.Container) {

        container.register(AppRootRouter.self) { resolver in
            AppRootRouter(resolver: resolver)
        }

        container.register(AppRootConfigurator.self) { resolver in
            AppRootConfigurator(resolver: resolver)
        }

        container.register(AppRootPresenter.self) { _, view in
            AppRootPresenter(view: view)
        }

        container.register(AppRootInteractor.self) { resolver, presenter in
            let localService = resolver.resolve(
                LocalDataStorage.self,
                name: DIName.swiftDataStorage
            )!
            return AppRootInteractor(presenter: presenter, dbService: localService)
        }
    }
    

}
