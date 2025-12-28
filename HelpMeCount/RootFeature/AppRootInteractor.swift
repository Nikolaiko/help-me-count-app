//
//  AppRootInteractor.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 27.12.2025.
//

import Foundation

class AppRootInteractor {

    private let presenter: AppRootPresenter
    private let dbService: LocalDataStorage

    init(presenter: AppRootPresenter, dbService: LocalDataStorage) {
        self.presenter = presenter
        self.dbService = dbService
    }

    func checkLoginStatus() {
        if let loggedUser = dbService.getLoggedUser() {
            presenter.userLoggedIn()
        } else {
            presenter.userNotLoggedIn()
        }
    }
}
