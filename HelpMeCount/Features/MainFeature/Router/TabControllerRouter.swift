//
//  TabControllerRouter.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 26.01.2026.
//

import UIKit
import Swinject

class TabControllerRouter: MainFeatureRouter {
    private let resolver: Resolver

    init(resolver: Resolver) {
        self.resolver = resolver
    }

    func routeToAddAction(parent: UINavigationController) throws {
        guard let configurator = resolver.resolve(MainFeatureConfigurator.self)
        else { throw DIErrors.unableToResolve }

        let viewController = AddActionViewController()
        try configurator.configure(view: viewController)

        parent.pushViewController(viewController, animated: true)
    }

    func routeToLogin(parent: UINavigationController) throws {
        guard let authConfigurator = resolver.resolve(AuthorizationConfigurator.self)
        else { throw DIErrors.unableToResolve }

        let login = LoginViewController()
        try authConfigurator.configure(view: login)

        parent.setViewControllers([login], animated: true)
    }

    func routeBackFromAddAction(parent: UINavigationController) {
        parent.popViewController(animated: true)
    }
}
