//
//  AuthAssembly.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 18.12.2025.
//

import Foundation
import Swinject

class AuthAssembly: Assembly {
    func assemble(container: Container) {
        container.register(AuthConfigurator.self) { resolver in
            AuthConfigurator(resolver: resolver)
        }

        container.register(AuthRouter.self) { resolver in
            AuthRouter(resolver: resolver)
        }

        registerLogin(container: container)
        registerRegistration(container: container)
    }

    func loaded(resolver: any Resolver) {
        
    }

    private func registerRegistration(container: Container) {
        container.register(RegisterPresenter.self) { _, view in
            RegisterPresenter(view: view)
        }
        container.register(RegisterInteractor.self) { resolver, presenter in
            RegisterInteractor(presenter: presenter,
                            networkService: resolver.resolve(NetworkService.self)!,
                               dbService: resolver.resolve(LocalDataStorage.self)!)
        }
    }

    private func registerLogin(container: Container) {
        container.register(LocalDataStorage.self) { _ in SwiftDataStorage() }
        container.register(NetworkService.self) { _ in AppNetworkService() }

        container.register(LoginPresenter.self) { _, view in LoginPresenter(view: view) }
        container.register(LoginInteractor.self) { resolver, presenter in
            LoginInteractor(presenter: presenter,
                            networkService: resolver.resolve(NetworkService.self)!,
                            storage: resolver.resolve(LocalDataStorage.self)!)
        }
    }
}
