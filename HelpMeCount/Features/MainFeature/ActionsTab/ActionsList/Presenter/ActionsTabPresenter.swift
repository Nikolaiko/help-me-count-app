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

    func displayActionsList(response: RefreshActions.Response) {
        view?.refreshActionsList(viewData: RefreshActions.ViewData(actions: response.actions))
    }

    func displayError(message: String) {
        
    }
}
