//
//  RootRouter.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 29.12.2025.
//

import UIKit
import Swinject

class RootRouter: AppRootRouter {

    private let resolver: Resolver

    init(resolver: Resolver) {
        self.resolver = resolver
    }

    func navigateToLogin(parent: UINavigationController) throws {
        guard let authConfigurator = resolver.resolve(AuthorizationConfigurator.self)
        else { throw DIErrors.unableToResolve }

        let controller = LoginViewController()
        try authConfigurator.configure(view: controller)

        parent.pushViewController(controller, animated: true)
    }

    func navigateToAuthorized(parent: UINavigationController) throws {
        guard let configurator = resolver.resolve(MainFeatureConfigurator.self)
        else { throw DIErrors.unableToResolve }

        let actionsTab = ActionsViewController()
        try configurator.configure(view: actionsTab)

        let tabController = MainViewController(childControllers: [
            actionsTab
        ])
        try configurator.configure(view: tabController)

        parent.pushViewController(tabController, animated: true)
    }
}
