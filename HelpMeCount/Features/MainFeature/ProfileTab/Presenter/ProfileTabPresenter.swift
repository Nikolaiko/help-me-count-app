//
//  ProfileTabPresenter.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 02.06.2026.
//

import Foundation

class ProfileTabPresenter: ProfilePresenter {
    private let view: ProfileViewController

    init(view: ProfileViewController) {
        self.view = view
    }

    func showLogoutConfirmation() {
        view.showLogoutConfirmation()
    }

    func returnToLoginScreen() {
        view.returnToLoginScreen()
    }
}
