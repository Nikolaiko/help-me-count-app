//
//  ActionsRouter.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 26.01.2026.
//

import UIKit

protocol ActionsRoutingLogic {
    func routeToAddAction()
}

protocol ActionsDataPassing {
    var dataStore: ActionsDataStore? { get }
}

protocol ActionsDataStore {
    // Пока сцены не делятся данными напрямую — слот на будущее.
}

class ActionsRouter: ActionsRoutingLogic, ActionsDataPassing {

    weak var viewController: ActionsViewController?
    var dataStore: ActionsDataStore?

    private let services: AppServices

    init(services: AppServices) {
        self.services = services
    }

    func routeToAddAction() {
        guard let source = viewController,
              let navParent = source.navigationController
        else { return }

        let destination = AddActionViewController()
        MainFeatureConfigurator(services: services).configure(view: destination)

        navigateToAddActionScene(source: navParent, destination: destination)
    }

    // MARK: Navigation

    private func navigateToAddActionScene(source: UINavigationController, destination: AddActionViewController) {
        source.pushViewController(destination, animated: true)
    }
}
