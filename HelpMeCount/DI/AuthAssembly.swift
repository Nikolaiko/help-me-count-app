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
        container.register(AuthConfigurator.self) { resolver, controller in
            AuthConfigurator(resolver: resolver, parentController: controller)
        }

        container.register(AuthRouter.self) { resolver, controller in
            AuthRouter(resolver: resolver, parentController: controller)
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
            let networkService = resolver.resolve(
                NetworkService.self,
                name: DIName.generatedNetworkLayer)!

            let localService = resolver.resolve(
                LocalDataStorage.self,
                name: DIName.swiftDataStorage)!

            return RegisterInteractor(presenter: presenter,
                                      networkService: networkService,
                                      dbService: localService)
        }
    }

    private func registerLogin(container: Container) {
        container.register(LoginPresenter.self) { _, view in
            LoginPresenter(view: view)
        }

        container.register(LoginInteractor.self) { resolver, presenter in
            let networkService = resolver.resolve(
                NetworkService.self,
                name: DIName.generatedNetworkLayer)!

            let localService = resolver.resolve(
                LocalDataStorage.self,
                name: DIName.swiftDataStorage)!

            return LoginInteractor(presenter: presenter,
                                   networkService: networkService,
                                   storage: localService)
        }
    }
}
