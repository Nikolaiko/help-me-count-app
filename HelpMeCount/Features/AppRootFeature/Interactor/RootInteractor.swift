//
//  RootInteractor.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 29.12.2025.
//

import Foundation

class RootInteractor: AppRootInteractor {
    private let presenter: AppRootPresenter
    private let localService: LocalStorageService

    init(presenter: AppRootPresenter, localService: LocalStorageService) {
        self.presenter = presenter
        self.localService = localService
    }

    func checkLoginStatus() {
        presenter.isUserLogged(isLogged: localService.getUserToken() != nil)
    }
}
