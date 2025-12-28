//
//  AppRootPresenter.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 27.12.2025.
//

import Foundation

class AppRootPresenter {
    private let view: AppRootViewController

    init(view: AppRootViewController) {
        self.view = view
    }

    func userLoggedIn() {
        view.userLoggedIn()
    }

    func userNotLoggedIn() {
        view.userNotLoggedIn()
    }
}
