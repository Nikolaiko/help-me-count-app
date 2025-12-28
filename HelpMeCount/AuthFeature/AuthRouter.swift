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

    init(resolver: Resolver) {
        self.resolver = resolver
    }

    func navigateToActions(parentController: UINavigationController) throws {
        guard let configurator = resolver.resolve(ActionsConfigurator.self)
        else { throw DIError.unableToResolveDependency }

        let actionsController = ActionsViewController()
        try configurator.configure(view: actionsController)

        parentController.popViewController(animated: true)
        parentController.pushViewController(actionsController, animated: true)
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
