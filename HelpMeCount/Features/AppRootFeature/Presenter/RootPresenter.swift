//
//  RootPresenter.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 29.12.2025.
//

import Foundation

class RootPresenter: AppRootPresenter {
    private weak var view: AppRootView?

    init(view: AppRootView) {
        self.view = view
    }

    func isUserLogged(isLogged: Bool) {
        view?.isUserLogged(isLogged: isLogged)
    }
}
