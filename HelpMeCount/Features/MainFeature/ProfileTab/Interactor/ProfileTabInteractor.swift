//
//  ProfileTabInteractor.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 02.06.2026.
//

import Foundation

class ProfileTabInteractor: ProfileInteractor {
    private let presenter: ProfilePresenter
    private let tokenStorage: LocalTokensStorage
    private let actionsStorage: LocalActionsStorage

    init(presenter: ProfilePresenter, tokenStorage: LocalTokensStorage, actionsStorage: LocalActionsStorage) {
        self.presenter = presenter
        self.tokenStorage = tokenStorage
        self.actionsStorage = actionsStorage
    }

    func logout() {
        presenter.showLogoutConfirmation()
    }

    func clearAllData() {
        actionsStorage.removeAllActions()
        tokenStorage.removeToken()
        presenter.returnToLoginScreen()
    }
}
