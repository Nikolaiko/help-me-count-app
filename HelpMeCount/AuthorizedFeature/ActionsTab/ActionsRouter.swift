//
//  ActionsRouter.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 19.01.2026.
//

import Foundation
import UIKit
import Swinject

class ActionsRouter {
    private let resolver: Resolver
    private let parentController: UINavigationController

    init(resolver: Resolver, parentController: UINavigationController) {
        self.resolver = resolver
        self.parentController = parentController
    }

    func goToAddAction() {
        let controller = AddActionViewController()

        parentController.pushViewController(controller, animated: true)
    }
}
