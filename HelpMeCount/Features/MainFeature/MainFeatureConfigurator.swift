//
//  MainFeatureConfigurator.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 07.01.2026.
//

import Foundation
import Swinject

class MainFeatureConfigurator {
    private let resolver: Resolver

    init(resolver: Resolver) {
        self.resolver = resolver
    }

    func configure(view: MainViewController) throws {

    }

    /// Собирает готовый таб-бар авторизованной зоны (actions + profile).
    /// Единая точка сборки — используется всеми роутерами, ведущими в authorized.
    func makeAuthorizedTabBar() throws -> MainViewController {
        let actionsTab = ActionsViewController()
        try configure(view: actionsTab)

        let profileTab = ProfileViewController()
        try configure(view: profileTab)

        let tabController = MainViewController(childControllers: [actionsTab, profileTab])
        try configure(view: tabController)

        return tabController
    }

    func configure(view: ProfileViewController) throws {
        guard let presenter = resolver.resolve(ProfilePresenter.self, argument: view),
              let interactor = resolver.resolve(ProfileInteractor.self, argument: presenter),
              let router = resolver.resolve(MainFeatureRouter.self)
        else { throw DIErrors.unableToResolve }

        view.router = router
        view.interactor = interactor
    }

    func configure(view: ActionsViewController) throws {
        guard let presenter = resolver.resolve(ActionsListPresenter.self, argument: view),
              let interactor = resolver.resolve(ActionsListInteractor.self, argument: presenter),
              let router = resolver.resolve(MainFeatureRouter.self)
        else { throw DIErrors.unableToResolve }

        view.router = router
        view.interactor = interactor
    }

    func configure(view: AddActionViewController) throws {
        guard let presenter = resolver.resolve(AddActionPresenter.self, argument: view),
              let interactor = resolver.resolve(AddActionInteractor.self, argument: presenter),
              let router = resolver.resolve(MainFeatureRouter.self)
        else { throw DIErrors.unableToResolve }

        view.interactor = interactor
        view.router = router
    }
}
