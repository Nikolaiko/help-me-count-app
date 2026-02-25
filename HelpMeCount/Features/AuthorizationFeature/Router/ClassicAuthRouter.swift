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

    func goToRegister(parent: UINavigationController) throws {
        guard let configurator = resolver.resolve(AuthorizationConfigurator.self)
        else { throw DIErrors.unableToResolve }

        let controller = RegisterViewController()
        try configurator.configure(view: controller)

        parent.pushViewController(controller, animated: true)
    }

    func goToAuthorizedScreen(parent: UINavigationController) throws {
        guard let configurator = resolver.resolve(MainFeatureConfigurator.self)
        else { throw DIErrors.unableToResolve }

        let actionsTab = ActionsViewController()
        try configurator.configure(view: actionsTab)

        let tabController = MainViewController(childControllers: [
            actionsTab
        ])
        try configurator.configure(view: tabController)

        parent.popToRootViewController(animated: true)
        parent.pushViewController(tabController, animated: true)
    }

    func backToLogin(parent: UINavigationController) {
        parent.popViewController(animated: true)
    }
}
