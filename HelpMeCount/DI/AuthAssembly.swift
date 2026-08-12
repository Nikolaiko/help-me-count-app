//
//  AuthAssembly.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 31.12.2025.
//

import Foundation
import Swinject

class AuthAssembly: Assembly {

    func assemble(container: Container) {
        registerLoginPart(container: container)
        registerRegistrationPart(container: container)

        container.register(AuthRouter.self) { resolver in
            ClassicAuthRouter(resolver: resolver)
        }

        container.register(AuthorizationConfigurator.self) { resolver in
            AuthorizationConfigurator(resolver: resolver)
        }
    }

    private func registerRegistrationPart(container: Container) {
        container.register(RegisterPresenter.self) { _, controller in
            ClassicRegisterPresenter(view: controller)
        }

        container.register(RegisterInteractor.self) { resolver, presenter in
            let worker = ClassicRegisterWorker(
                networkService: resolver.resolve(NetworkService.self, name: DINames.generatedAPI)!,
                tokensStorage: resolver.resolve(LocalTokensStorage.self)!
            )
            return ClassicRegisterInteractor(presenter: presenter, worker: worker)
        }
    }

    private func registerLoginPart(container: Container) {
        container.register(LoginPresenter.self) { _, controller in
            ClassicLoginPresenter(view: controller)
        }

        container.register(LoginInteractor.self) { resolver, presenter in
            let worker = ClassicLoginWorker(
                networkService: resolver.resolve(NetworkService.self, name: DINames.generatedAPI)!,
                tokensStorage: resolver.resolve(LocalTokensStorage.self)!
            )
            return ClassicLoginInteractor(presenter: presenter, worker: worker)
        }
    }
}
