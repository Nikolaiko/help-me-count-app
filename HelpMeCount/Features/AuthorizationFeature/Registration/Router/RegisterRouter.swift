//
//  RegisterRouter.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 31.12.2025.
//

import UIKit

protocol RegisterRoutingLogic {
    func routeToAuthorized()
    func routeBackToLogin()
}

protocol RegisterDataPassing {
    var dataStore: RegisterDataStore? { get }
}

protocol RegisterDataStore {
    // Пока сцены не делятся данными напрямую — слот на будущее.
}

class RegisterRouter: RegisterRoutingLogic, RegisterDataPassing {

    weak var viewController: RegisterViewController?
    var dataStore: RegisterDataStore?

    private let services: AppServices

    init(services: AppServices) {
        self.services = services
    }

    func routeToAuthorized() {
        guard let source = viewController,
              let navParent = source.navigationController
        else { return }

        let tabController = MainFeatureConfigurator(services: services).makeAuthorizedTabBar()

        navigateToAuthorizedScene(source: navParent, destination: tabController)
    }

    func routeBackToLogin() {
        guard let source = viewController else { return }

        source.navigationController?.popViewController(animated: true)
    }

    // MARK: Navigation

    private func navigateToAuthorizedScene(source: UINavigationController, destination: MainViewController) {
        source.popToRootViewController(animated: true)
        source.pushViewController(destination, animated: true)
    }
}
