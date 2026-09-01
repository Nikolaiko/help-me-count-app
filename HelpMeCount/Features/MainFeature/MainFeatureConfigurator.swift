//
//  MainFeatureConfigurator.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 07.01.2026.
//

import Foundation

class MainFeatureConfigurator {

    private let services: AppServices

    init(services: AppServices) {
        self.services = services
    }

    func configure(view: MainViewController) {

    }

    /// Собирает готовый таб-бар авторизованной зоны (actions + profile).
    /// Единая точка сборки — используется всеми роутерами, ведущими в authorized.
    func makeAuthorizedTabBar() -> MainViewController {
        let actionsTab = ActionsViewController()
        configure(view: actionsTab)

        let profileTab = ProfileViewController()
        configure(view: profileTab)

        let tabController = MainViewController(childControllers: [actionsTab, profileTab])
        configure(view: tabController)

        return tabController
    }

    func configure(view: ProfileViewController) {
        let presenter = ProfileTabPresenter(view: view)
        let worker = ProfileTabWorker(
            tokenStorage: services.tokensStorage,
            actionsStorage: services.actionsStorage
        )
        let interactor = ProfileTabInteractor(presenter: presenter, worker: worker)
        let router = ProfileRouter(services: services)

        router.viewController = view
        router.dataStore = interactor

        view.router = router
        view.interactor = interactor
    }

    func configure(view: ActionsViewController) {
        let presenter = ActionsTabPresenter(view: view)
        let worker = ActionsTabWorker(
            networkLayer: services.networkService,
            actionsStorage: services.actionsStorage
        )
        let interactor = ActionsTabInteractor(presenter: presenter, worker: worker)
        interactor.initSubscriptions()
        let router = ActionsRouter(services: services)

        router.viewController = view
        router.dataStore = interactor

        view.router = router
        view.interactor = interactor
    }

    func configure(view: AddActionViewController) {
        let presenter = CreateActionPresenter(view: view)
        let worker = CreateActionWorker(
            networkService: services.networkService,
            localDataStorage: services.actionsStorage
        )
        let interactor = CreateActionInteractor(presenter: presenter, worker: worker)
        let router = AddActionRouter(services: services)

        router.viewController = view
        router.dataStore = interactor

        view.interactor = interactor
        view.router = router
    }
}
