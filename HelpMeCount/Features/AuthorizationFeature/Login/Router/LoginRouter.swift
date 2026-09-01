//
//  LoginRouter.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 31.12.2025.
//

import UIKit

protocol LoginRoutingLogic {
    func routeToRegister()
    func routeToAuthorized()
}

protocol LoginDataPassing {
    var dataStore: LoginDataStore? { get }
}

protocol LoginDataStore {
    // Пока сцены не делятся данными напрямую — слот на будущее.
}

class LoginRouter: LoginRoutingLogic, LoginDataPassing {

    weak var viewController: LoginViewController?
    var dataStore: LoginDataStore?

    private let services: AppServices

    init(services: AppServices) {
        self.services = services
    }

    func routeToRegister() {
        guard let source = viewController,
              let navParent = source.navigationController
        else { return }

        let destination = RegisterViewController()
        AuthorizationConfigurator(services: services).configure(view: destination)

        navigateToRegisterScene(source: navParent, destination: destination)
    }

    func routeToAuthorized() {
        guard let source = viewController,
              let navParent = source.navigationController
        else { return }

        let tabController = MainFeatureConfigurator(services: services).makeAuthorizedTabBar()

        navigateToAuthorizedScene(source: navParent, destination: tabController)
    }

    // MARK: Navigation

    private func navigateToRegisterScene(source: UINavigationController, destination: RegisterViewController) {
        source.pushViewController(destination, animated: true)
    }

    private func navigateToAuthorizedScene(source: UINavigationController, destination: MainViewController) {
        source.popToRootViewController(animated: true)
        source.pushViewController(destination, animated: true)
    }
}
