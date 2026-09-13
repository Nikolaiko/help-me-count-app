//
//  ClassicAuthRouter.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 31.12.2025.
//

import UIKit

final class AuthViewControllerRouter: AuthRouter {
    weak var controller: NavigatableView?

    private let appFactory: AuthorizedSceneFactory

    init(appFactory: AuthorizedSceneFactory) {
        self.appFactory = appFactory
    }

    func goToRegister() throws {
        guard let navParent = controller?.getNavController() else { throw NavigationErrors.parentNotFound }

        let controller = appFactory.makeRegister()
        navParent.pushViewController(controller, animated: true)
    }

    func goToAuthorizedScreen() throws {
        guard let navParent = controller?.getNavController() else { throw NavigationErrors.parentNotFound }

        let view = appFactory.makeAuthorizedTabBar()
        navParent.popToRootViewController(animated: true)
        navParent.pushViewController(view, animated: true)
    }

    func backToLogin() throws {
        guard let navParent = controller?.getNavController() else { throw NavigationErrors.parentNotFound }

        navParent.popViewController(animated: true)
    }
}
