//
//  ActionDetailConfigurator.swift
//  HelpMeCount
//

import Foundation

enum ActionDetailConfigurator {
    static func scene() -> (viewController: ActionDetailViewController, router: ActionDetailRouter) {
        let viewController = ActionDetailViewController()
        let interactor = ActionDetailInteractor()
        let presenter = ActionDetailPresenter()
        let router = ActionDetailRouter()

        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor

        return (viewController, router)
    }
}
