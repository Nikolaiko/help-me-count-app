//
//  AppRootRouter.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 27.12.2025.
//

import Foundation
import UIKit
import Swinject

struct AppRootRouter {

    private let resolver: Resolver

    init(resolver: Resolver) {
        self.resolver = resolver
    }

    func navigateToLogin(navController: UINavigationController) throws {
        guard let configurator = resolver.resolve(AuthConfigurator.self)
        else { throw DIError.unableToResolveDependency }

        let loginController = LoginViewController()
        try configurator.configure(view: loginController)
        navController.pushViewController(loginController, animated: true)
    }

    func navigateToMain(navController: UINavigationController) throws {
        guard let configurator = resolver.resolve(ActionsConfigurator.self)
        else { throw DIError.unableToResolveDependency }

        let actionsController = ActionsViewController()
        try configurator.configure(view: actionsController)

        navController.pushViewController(actionsController, animated: true)
    }
}
