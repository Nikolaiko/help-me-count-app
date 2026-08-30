//
//  RootRouter.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 29.12.2025.
//

import UIKit

class RootRouter: AppRootRouter {

    private let services: AppServices

    init(services: AppServices) {
        self.services = services
    }

    func routeToLogin(parent: UINavigationController) {
        let controller = LoginViewController()
        AuthorizationConfigurator(services: services).configure(view: controller)

        parent.pushViewController(controller, animated: true)
    }

    func routeToAuthorized(parent: UINavigationController) {
        let tabController = MainFeatureConfigurator(services: services).makeAuthorizedTabBar()

        parent.pushViewController(tabController, animated: true)
    }
}
