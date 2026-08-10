//
//  ActionsBoardConfigurator.swift
//  HelpMeCount
//
//  Сборка сцены. В каноне это часто делается прямо во ViewController (setup()/awakeFromNib),
//  но вынесем в отдельный тип для наглядности. Ключевые две строки — router.viewController
//  и router.dataStore: именно они дают роутеру его VC и доступ к состоянию сцены.
//

import Foundation

enum ActionsBoardConfigurator {
    static func scene() -> (viewController: ActionsBoardViewController, router: ActionsBoardRouter) {
        let viewController = ActionsBoardViewController()
        let interactor = ActionsBoardInteractor()
        let presenter = ActionsBoardPresenter()
        let router = ActionsBoardRouter()

        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController   // роутер держит свой VC
        router.dataStore = interactor            // роутер видит DataStore сцены

        return (viewController, router)
    }
}
