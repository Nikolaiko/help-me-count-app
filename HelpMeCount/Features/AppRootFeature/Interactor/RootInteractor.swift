//
//  RootInteractor.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 29.12.2025.
//

import Foundation

class RootInteractor: AppRootInteractor, AppRootDataStore {
    private let presenter: AppRootPresenter
    private let worker: AppRootWorker

    init(presenter: AppRootPresenter, worker: AppRootWorker) {
        self.presenter = presenter
        self.worker = worker
    }

    func checkLoginStatus(request: AppRoot.CheckLoginStatus.Request) {
        let response = AppRoot.CheckLoginStatus.Response(
            isLogged: worker.isUserLoggedIn()
        )
        presenter.presentLoginStatus(response: response)
    }
}
