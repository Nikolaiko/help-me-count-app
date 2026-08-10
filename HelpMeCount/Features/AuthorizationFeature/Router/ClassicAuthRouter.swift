//
//  ClassicAuthRouter.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 31.12.2025.
//

import UIKit
import Swinject

class ClassicAuthRouter: AuthRouter {
    private let resolver: Resolver

    init(resolver: Resolver) {
        self.resolver = resolver
    }

    func routeToRegister(parent: UINavigationController) throws {
        guard let configurator = resolver.resolve(AuthorizationConfigurator.self)
        else { throw DIErrors.unableToResolve }

        let controller = RegisterViewController()
        try configurator.configure(view: controller)

        parent.pushViewController(controller, animated: true)
    }

    func routeToAuthorized(parent: UINavigationController) throws {
        guard let configurator = resolver.resolve(MainFeatureConfigurator.self)
        else { throw DIErrors.unableToResolve }

        let tabController = try configurator.makeAuthorizedTabBar()

        parent.popToRootViewController(animated: true)
        parent.pushViewController(tabController, animated: true)
    }

    func routeBackToLogin(parent: UINavigationController) {
        parent.popViewController(animated: true)
    }
}
