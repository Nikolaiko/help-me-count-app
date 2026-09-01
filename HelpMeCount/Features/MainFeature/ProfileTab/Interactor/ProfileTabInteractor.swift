//
//  ProfileTabInteractor.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 02.06.2026.
//

import Foundation

class ProfileTabInteractor: ProfileInteractor, ProfileDataStore {
    private let presenter: ProfilePresenter
    private let worker: ProfileWorker

    init(presenter: ProfilePresenter, worker: ProfileWorker) {
        self.presenter = presenter
        self.worker = worker
    }

    func logout() {
        presenter.showLogoutConfirmation()
    }

    func clearAllData() {
        worker.clearAllData()
        presenter.returnToLoginScreen()
    }
}
