//
//  TabControllerRouter.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 26.01.2026.
//

import UIKit

class TabControllerRouter: MainFeatureRouter {

    private let services: AppServices

    init(services: AppServices) {
        self.services = services
    }

    func routeToAddAction(parent: UINavigationController) {
        let viewController = AddActionViewController()
        MainFeatureConfigurator(services: services).configure(view: viewController)

        parent.pushViewController(viewController, animated: true)
    }

    func routeToLogin(parent: UINavigationController) {
        let login = LoginViewController()
        AuthorizationConfigurator(services: services).configure(view: login)

        parent.setViewControllers([login], animated: true)
    }

    func routeBackFromAddAction(parent: UINavigationController) {
        parent.popViewController(animated: true)
    }
}
