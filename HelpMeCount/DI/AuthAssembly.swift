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
        container.register(LoginPresenter.self) { _, controller in
            ClassicLoginPresenter(view: controller)
        }

        container.register(LoginInteractor.self) { resolver, presenter in
            ClassicLoginInteractor(
                presenter: presenter,
                localStorage: resolver.resolve(LocalStorageService.self, name: "always_not_logged")!,
                networkService: resolver.resolve(NetworkService.self, name: "always_fail_login")!
            )
        }

        container.register(AuthRouter.self) { resolver in
            ClassicAuthRouter(resolver: resolver)
        }

        container.register(AuthorizationConfigurator.self) { resolver in
            AuthorizationConfigurator(resolver: resolver)
        }
    }
}
