//
//  AppFactory.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 15.08.2026.
//

import Foundation

protocol AppRootSceneFactory {
    func makeLogin() -> LoginViewController
    func makeAuthorizedTabBar() -> MainViewController
}

protocol AuthorizedSceneFactory {
    func makeRegister() -> RegisterViewController
    func makeAuthorizedTabBar() -> MainViewController
}

protocol MainSceneFactory {
    func makeLogin() -> LoginViewController
    func makeAddAction() -> AddActionViewController
}

final class AppFactory: AppRootSceneFactory, AuthorizedSceneFactory, MainSceneFactory {

    private let service: ServiceFactory

    init(service: ServiceFactory) {
        self.service = service
    }

    func appRoot() -> AppRootViewController {
        let view = AppRootViewController()
        let presenter = RootPresenter(view: view)
        let interactor = RootInteractor(presenter: presenter, localService: service.tokenStorage)
        let router = RootRouter(appFactory: self)

        view.interactor = interactor
        view.router = router

        return view
    }

    func makeLogin() -> LoginViewController {
        let view = LoginViewController()
        let presenter = ClassicLoginPresenter(view: view)
        let interactor = ClassicLoginInteractor(presenter: presenter, localStorage: service.tokenStorage, networkService: service.api)
        let router = ClassicAuthRouter(appFactory: self)

        view.interactor = interactor
        view.router = router

        return view
    }

    func makeRegister() -> RegisterViewController {
        let view = RegisterViewController()
        let presenter = ClassicRegisterPresenter(view: view)
        let interactor = ClassicRegisterInteractor(
            presenter: presenter,
            localStorage: service.tokenStorage,
            networkService: service.api
        )
        let router = ClassicAuthRouter(appFactory: self)

        view.interactor = interactor
        view.router = router
        return view
    }

    func  makeAuthorizedTabBar() -> MainViewController {
        let actions = makeActions()
        let profile = makeProfile()
        let view = MainViewController(childControllers: [actions, profile])
        return view
    }

    func makeAddAction() -> AddActionViewController {
        let view = AddActionViewController()
        let presenter = CreateActionPresenter(view: view)
        let interactor = CreateActionInteractor(
            presenter: presenter,
            networkService: service.api,
            localDataStorage: service.actionStorage
        )
        let router = TabControllerRouter(appFactory: self)

        view.interactor = interactor
        view.router = router
        return view
    }

    private func makeActions() -> ActionsViewController {
        let view = ActionsViewController()
        let presenter = ActionsTabPresenter(view: view)
        let interactor = ActionsTabInteractor(
            networkLayer: service.api,
            presenter: presenter,
            actionsStorage: service.actionStorage
        )
        interactor.initSubscriptions()
        let router = TabControllerRouter(appFactory: self)

        view.interactor = interactor
        view.router = router
        return view
    }

    private func makeProfile() -> ProfileViewController {
        let view = ProfileViewController()
        let presenter = ProfileTabPresenter(view: view)
        let interactor = ProfileTabInteractor(
            presenter: presenter,
            tokenStorage: service.tokenStorage,
            actionsStorage: service.actionStorage
        )
        let router = TabControllerRouter(appFactory: self)

        view.interactor = interactor
        view.router = router
        return view
    }
}
