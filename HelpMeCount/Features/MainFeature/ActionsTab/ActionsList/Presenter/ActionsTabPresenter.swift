//
//  ActionsTabPresenter.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 15.03.2026.
//

import Foundation

struct ActionsTabPresenter: ActionsListPresenter {
    private let view: ActionsViewController

    init(view: ActionsViewController) {
        self.view = view
    }

    func displayActionsList(actions: [CountableAction]) {
        view.refreshActionsList(actions: actions)
    }

    func displayError(message: String) {
        
    }
}
