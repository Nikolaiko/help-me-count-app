//
//  AuthorizationConfigurator.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 31.12.2025.
//

import Foundation

class AuthorizationConfigurator {

    private let services: AppServices

    init(services: AppServices) {
        self.services = services
    }

    func configure(view: LoginViewController) {
        let presenter = ClassicLoginPresenter(view: view)
        let worker = ClassicLoginWorker(
            networkService: services.networkService,
            tokensStorage: services.tokensStorage
        )
        let interactor = ClassicLoginInteractor(presenter: presenter, worker: worker)
        let router = ClassicAuthRouter(services: services)

        view.interactor = interactor
        view.router = router
    }

    func configure(view: RegisterViewController) {
        let presenter = ClassicRegisterPresenter(view: view)
        let worker = ClassicRegisterWorker(
            networkService: services.networkService,
            tokensStorage: services.tokensStorage
        )
        let interactor = ClassicRegisterInteractor(presenter: presenter, worker: worker)
        let router = ClassicAuthRouter(services: services)

        view.interactor = interactor
        view.router = router
    }
}
