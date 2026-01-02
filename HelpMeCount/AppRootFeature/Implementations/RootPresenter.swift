//
//  RootPresenter.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 29.12.2025.
//

import Foundation

class RootPresenter: AppRootPresenter {
    private let view: AppRootViewController

    init(view: AppRootViewController) {
        self.view = view
    }

    func isUserLogged(isLogged: Bool) {
        view.isUserLogged(isLogged: isLogged)
    }
}
