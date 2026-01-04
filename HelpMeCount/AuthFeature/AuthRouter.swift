//
//  LoginRouter.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 11.11.2025.
//

import Foundation
import Swinject
import UIKit

struct AuthRouter {

    private let resolver: Resolver
    private let parentController: UINavigationController

    init(resolver: Resolver, parentController: UINavigationController) {
        self.resolver = resolver
        self.parentController = parentController
    }

    func navigateToActions() throws {
        guard let configurator = resolver.resolve(AuthorizedControllerConfigurator.self, argument: parentController)
        else { throw DIError.unableToResolveDependency }

        let actionsController = ActionsViewController()
        try configurator.configure(view: actionsController)

        let rootController = MainTabBarViewController(childTabs: [
            actionsController
        ])
        try configurator.configure(view: rootController)

        parentController.popViewController(animated: true)
        parentController.pushViewController(rootController, animated: true)
    }

    func navigateToRegister(source: UIViewController) throws {
        guard let configurator = resolver.resolve(AuthConfigurator.self)
        else { throw DIError.unableToResolveDependency }

        let registerViewController = RegisterViewController()
        try configurator.configure(view: registerViewController)

        registerViewController.modalPresentationStyle = .fullScreen
        source.present(registerViewController, animated: true)
    }

    func backToLogin(from registerController: UIViewController) {
        registerController.dismiss(animated: true)
    }
}
