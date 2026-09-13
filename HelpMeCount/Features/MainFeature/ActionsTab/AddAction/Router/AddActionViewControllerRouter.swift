//
//  AddActionViewControllerRouter.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 13.09.2026.
//

import Foundation

final class AddActionViewControllerRouter: AddActionRouter {
    weak var controller: AddActionView?

    func backFromAddActions() throws {
        guard let navController = controller?.getNavController() else { throw NavigationErrors.parentNotFound }

        navController.popViewController(animated: true)

        (navController.topViewController as? MainViewController)?.passDataActionsList(message: "Hello from AddActionViewController")
    }
}
