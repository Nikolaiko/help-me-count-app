//
//  AddActionPresenter.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 25.01.2026.
//

import Foundation

class AddActionPresenter {
    private let view: AddActionViewController

    init(view: AddActionViewController) {
        self.view = view
    }

    func errorDuringOperation(error: ActionOperationError) {
        view.showAlert(title: error.title)
    }

    func addedAction() {
        
    }

    func addButtonEnabled(_ isEnabled: Bool) {
        view.setAddActionEnabled(isEnabled)
    }
}
