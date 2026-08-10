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
        guard let configurator = resolver.resolve(MainFeatureConfigurator.self)
        else { throw DIErrors.unableToResolve }

        let viewController = AddActionViewController()
        try configurator.configure(view: viewController)

        parent.pushViewController(viewController, animated: true)
    }

    func navigateToLogin(parent: UINavigationController) throws {
        parent.popToRootViewController(animated: true)

        guard let root = parent.topViewController as? AppRootViewController
        else { throw DIErrors.unableToResolve }

        root.interactor?.checkLoginStatus(request: AppRoot.CheckLoginStatus.Request())
    }

    func backFromAddAction(parent: UINavigationController) {
        parent.popViewController(animated: true)
    }
}
