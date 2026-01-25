//
//  ActionsRouter.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 19.01.2026.
//

import Foundation
import UIKit
import Swinject

class AppAuthorizedRouter {
    private let resolver: Resolver
    private let parentController: UINavigationController

    init(resolver: Resolver, parentController: UINavigationController) {
        self.resolver = resolver
        self.parentController = parentController
    }

    func goToAddAction() throws {
        guard let configurator = resolver.resolve(ActionsConfigurator.self, argument: parentController)
        else { throw DIError.unableToResolveDependency }

        let controller = AddActionViewController()
        try configurator.configure(view: controller)

        parentController.pushViewController(controller, animated: true)
    }

    func returnFromAddAction() {
        parentController.popViewController(animated: true)
    }
}
