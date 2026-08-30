//
//  AppRootConfigurator.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 29.12.2025.
//

import Foundation

struct AppRootConfigurator {

    private let services: AppServices

    init(services: AppServices) {
        self.services = services
    }

    func configure(view: AppRootViewController) {
        let presenter = RootPresenter(view: view)
        let worker = AppRootTokenWorker(tokensStorage: services.tokensStorage)
        let interactor = RootInteractor(presenter: presenter, worker: worker)
        let router = RootRouter(services: services)

        view.interactor = interactor
        view.router = router
    }
}
