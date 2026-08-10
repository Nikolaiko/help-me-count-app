//
//  RootInteractor.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 29.12.2025.
//

import Foundation

class RootInteractor: AppRootInteractor {
    private let presenter: AppRootPresenter
    private let localService: LocalTokensStorage

    init(presenter: AppRootPresenter, localService: LocalTokensStorage) {
        self.presenter = presenter
        self.localService = localService
    }

    func checkLoginStatus(request: AppRoot.CheckLoginStatus.Request) {
        let response = AppRoot.CheckLoginStatus.Response(
            isLogged: localService.getUserToken() != nil
        )
        presenter.presentLoginStatus(response: response)
    }
}
