//
//  ProfileRouter.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 26.01.2026.
//

import UIKit

protocol ProfileRoutingLogic {
    func routeToLogin()
}

protocol ProfileDataPassing {
    var dataStore: ProfileDataStore? { get }
}

protocol ProfileDataStore {
    // Пока сцены не делятся данными напрямую — слот на будущее.
}

class ProfileRouter: ProfileRoutingLogic, ProfileDataPassing {

    weak var viewController: ProfileViewController?
    var dataStore: ProfileDataStore?

    private let services: AppServices

    init(services: AppServices) {
        self.services = services
    }

    func routeToLogin() {
        guard let source = viewController,
              let navParent = source.navigationController
        else { return }

        let destination = LoginViewController()
        AuthorizationConfigurator(services: services).configure(view: destination)

        navigateToLoginScene(source: navParent, destination: destination)
    }

    // MARK: Navigation

    private func navigateToLoginScene(source: UINavigationController, destination: LoginViewController) {
        source.setViewControllers([destination], animated: true)
    }
}
