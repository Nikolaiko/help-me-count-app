//
//  ProfileViewControllerRouter.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 13.09.2026.
//

import Foundation

final class ProfileViewControllerRouter: ProfileRouter {
    weak var controller: ProfileView?

    func navigateToLogin() throws {
        guard let navParent = controller?.getNavController() else { throw NavigationErrors.parentNotFound }

        navParent.popToRootViewController(animated: true)

        guard let root = navParent.topViewController as? AppRootViewController
        else { throw DIErrors.unableToResolve }

        root.interactor?.checkLoginStatus()
    }
}
