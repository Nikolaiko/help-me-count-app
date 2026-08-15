//
//  ClassicAuthRouter.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 31.12.2025.
//

import UIKit

class ClassicAuthRouter: AuthRouter {
    private let appFactory: AuthorizedSceneFactory

    init(appFactory: AuthorizedSceneFactory) {
        self.appFactory = appFactory
    }

    func goToRegister(parent: UINavigationController) throws {
        let controller = appFactory.makeRegister()
        parent.pushViewController(controller, animated: true)
    }

    func goToAuthorizedScreen(parent: UINavigationController) throws {
        let view = appFactory.makeAuthorizedTabBar()
        parent.popToRootViewController(animated: true)
        parent.pushViewController(view, animated: true)
    }

    func backToLogin(parent: UINavigationController) {
        parent.popViewController(animated: true)
    }
}
