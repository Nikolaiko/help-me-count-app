//
//  ActionsPresenter.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 28.12.2025.
//

import Foundation

class ActionsPresenter {
    private let view: ActionsViewController

    init(view: ActionsViewController) {
        self.view = view
    }

    func errorDuringOperation(error: ActionOperationError) {
        view.showAlert(title: error.title)
    }

    func updateActionsList(actions: [CountableAction]) {
        view.updateActionsList(actions: actions.map { $0.toRepeatableAction() } )
    }
}
