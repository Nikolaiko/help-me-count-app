//
//  TabControllerRouter.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 26.01.2026.
//

import UIKit

class TabControllerRouter: MainFeatureRouter {
    private let appFactory: MainSceneFactory

    init(appFactory: MainSceneFactory) {
        self.appFactory = appFactory
    }

    func navigateToAddAction(parent: UINavigationController) throws {
        let viewController = appFactory.makeAddAction()
        parent.pushViewController(viewController, animated: true)
    }

    func navigateToLogin(parent: UINavigationController) throws {
        parent.popToRootViewController(animated: true)

        guard let root = parent.topViewController as? AppRootViewController
        else { throw DIErrors.unableToResolve }

        root.interactor?.checkLoginStatus()
    }

    func backFromAddAction(parent: UINavigationController) {
        parent.popViewController(animated: true)
    }
}
