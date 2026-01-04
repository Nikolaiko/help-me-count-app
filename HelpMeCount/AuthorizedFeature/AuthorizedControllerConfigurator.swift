//
//  AuthorizedControllerConfigurator.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 29.12.2025.
//

import UIKit
import Swinject

class AuthorizedControllerConfigurator {
    private let resolver: Resolver
    private let parentController: UINavigationController

    init(resolver: Resolver, parentController: UINavigationController) {
        self.resolver = resolver
        self.parentController = parentController
    }

    public func configure(view: MainTabBarViewController) throws {

    }

    public func configure(view: ActionsViewController) throws {
        guard let actionsConfigurator = resolver.resolve(ActionsConfigurator.self, argument: parentController)
        else { throw DIError.unableToResolveDependency }

        try actionsConfigurator.configure(view: view)
    }
}
