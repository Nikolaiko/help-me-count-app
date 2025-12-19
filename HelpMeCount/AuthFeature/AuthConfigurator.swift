//
//  LoginConfigurator.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 09.11.2025.
//

import Foundation
import Swinject

class AuthConfigurator {

    private let resolver: Resolver

    init(resolver: Resolver) {
        self.resolver = resolver
    }

    func configure(view: LoginViewController) throws {
        guard let presenter = resolver.resolve(LoginPresenter.self, argument: view),
              let interactor = resolver.resolve(LoginInteractor.self, argument: presenter),
              let router = resolver.resolve(AuthRouter.self)
        else { throw DIError.unableToResolveDependency }

        view.interactor = interactor
        view.router = router
    }

    func configure(view: RegisterViewController) throws {
        guard let presenter = resolver.resolve(RegisterPresenter.self, argument: view),
              let interactor = resolver.resolve(RegisterInteractor.self, argument: presenter),
              let router = resolver.resolve(AuthRouter.self)
        else { throw DIError.unableToResolveDependency }

        view.interactor = interactor
        view.router = router
    }
}
