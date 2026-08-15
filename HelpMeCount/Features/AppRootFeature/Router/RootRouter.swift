//
//  RootRouter.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 29.12.2025.
//

import UIKit

class RootRouter: AppRootRouter {

    private let appFactory: AppRootSceneFactory

    init(appFactory: AppRootSceneFactory) {
        self.appFactory = appFactory
    }

    func navigateToLogin(parent: UINavigationController) throws {
        let view = appFactory.makeLogin()
        parent.pushViewController(view, animated: true)
    }

    func navigateToAuthorized(parent: UINavigationController) throws {
        let tabController = appFactory.makeAuthorizedTabBar()
        parent.pushViewController(tabController, animated: true)
    }
}
