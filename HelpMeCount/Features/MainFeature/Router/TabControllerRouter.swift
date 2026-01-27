//
//  TabControllerRouter.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 26.01.2026.
//

import UIKit
import Swinject

class TabControllerRouter: MainFeatureRouter {
    private let resolver: Resolver

    init(resolver: Resolver) {
        self.resolver = resolver
    }

    func navigateToAddAction(parent: UINavigationController) throws {
        let viewController = AddActionViewController()

        parent.pushViewController(viewController, animated: true)
    }
}
