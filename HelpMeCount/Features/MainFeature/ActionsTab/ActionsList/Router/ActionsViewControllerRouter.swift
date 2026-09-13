//
//  ActionsViewControllerRouter.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 13.09.2026.
//

import Foundation

final class ActionsViewControllerRouter: ActionsListRouter {
    weak var controller: ActionsView?

    private let appFactory: MainSceneFactory

    public init(appFactory: MainSceneFactory) {
        self.appFactory = appFactory
    }

    func navigateToAddAction() throws {
        guard let navParent = controller?.getNavController() else { throw NavigationErrors.parentNotFound }

        let addAction = appFactory.makeAddAction()
        addAction.interactor?.passedDate = (controller?.interactor as? ActionsListDateProvider)?.currentDate() ?? Date()
        navParent.pushViewController(addAction, animated: true)
    }
}
