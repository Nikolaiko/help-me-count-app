//
//  ActionsTabPresenter.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 15.03.2026.
//

import Foundation

struct ActionsTabPresenter: ActionsListPresenter {
    private weak var view: ActionsView?

    init(view: ActionsView) {
        self.view = view
    }

    func displayActionsList(actions: [CountableAction]) {
        view?.refreshActionsList(actions: actions)
    }

    func displayError(message: String) {
        
    }
}
