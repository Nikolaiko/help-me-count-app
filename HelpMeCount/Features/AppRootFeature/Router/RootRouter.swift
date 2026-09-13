//
//  RootRouter.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 29.12.2025.
//

import UIKit

final class AppRootViewControllerRouter: AppRootRouter {
    weak var controller: AppRootView?

    private let appFactory: AppRootSceneFactory

    init(appFactory: AppRootSceneFactory) {
        self.appFactory = appFactory
    }

    func navigateToLogin() throws {
        guard let navParent = controller?.getNavController() else { throw NavigationErrors.parentNotFound }

        let view = appFactory.makeLogin()
        navParent.pushViewController(view, animated: true)
    }

    func navigateToAuthorized() throws {
        guard let navParent = controller?.getNavController() else { throw NavigationErrors.parentNotFound }

        let tabController = appFactory.makeAuthorizedTabBar()
        navParent.pushViewController(tabController, animated: true)
    }
}
