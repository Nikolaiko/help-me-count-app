//
//  ClassicAuthRouter.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 31.12.2025.
//

import UIKit

class ClassicAuthRouter: AuthRouter {

    private let services: AppServices

    init(services: AppServices) {
        self.services = services
    }

    func routeToRegister(parent: UINavigationController) {
        let controller = RegisterViewController()
        AuthorizationConfigurator(services: services).configure(view: controller)

        parent.pushViewController(controller, animated: true)
    }

    func routeToAuthorized(parent: UINavigationController) {
        let tabController = MainFeatureConfigurator(services: services).makeAuthorizedTabBar()

        parent.popToRootViewController(animated: true)
        parent.pushViewController(tabController, animated: true)
    }

    func routeBackToLogin(parent: UINavigationController) {
        parent.popViewController(animated: true)
    }
}
