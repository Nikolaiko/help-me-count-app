//
//  AddActionInteractor.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 25.01.2026.
//

import Foundation

class AddActionInteractor {
    private let presenter: AddActionPresenter
    private let networkService: NetworkService
    private let localStorage: LocalDataStorage

    private var maxCounts = 0
    private var currentCounts = 0
    private var actionName = ""

    init(presenter: AddActionPresenter,
         networkService: NetworkService,
         localStorage: LocalDataStorage
    ) {
        self.presenter = presenter
        self.networkService = networkService
        self.localStorage = localStorage
    }

    func updateActionName(_ name: String) {
        actionName = name
        presenter.addButtonEnabled(validateValues())
    }

    func updateMaxCounts(_ maxCounts: Int) {
        self.maxCounts = maxCounts
        presenter.addButtonEnabled(validateValues())
    }

    func updateCurrentCount(_ currentCount: Int) {
        self.currentCounts = currentCount
        presenter.addButtonEnabled(validateValues())
    }

    func addAction() async {
        let action = NewCountableAction(title: actionName, maxRepeates: maxCounts, currentRepeats: currentCounts)
        guard let token = localStorage.getLoggedUser()?.token
        else {
            presenter.errorDuringOperation(error: .noLoggedTokenFound)
            return
        }

        if let addedAction = await networkService.addAction(
            token: token,
            newAction: action
        ) { presenter.addedAction() }
        else { presenter.errorDuringOperation(error: .errorDuringRequest) }
    }

    private func validateValues() -> Bool {
        !actionName.isEmpty && maxCounts > 0 && currentCounts <= maxCounts
    }
}
