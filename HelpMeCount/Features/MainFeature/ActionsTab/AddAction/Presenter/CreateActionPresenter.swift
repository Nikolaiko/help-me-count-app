//
//  CreateActionPresenter.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 18.02.2026.
//

import Foundation

struct CreateActionPresenter: AddActionPresenter {
    private let view: AddActionViewController

    init(view: AddActionViewController) {
        self.view = view
    }

    func setAddButtonEnabled(enabled: Bool) {
        view.setAddButtonEnabled(enabled: enabled)
    }

    func newActionAdded() {
        view.newActionAdded()
    }
}
