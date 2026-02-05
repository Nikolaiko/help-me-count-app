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

    private var maxCounts: Int? = nil
    private var currentCounts: Int? = nil
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

    func updateMaxCounts(_ maxCounts: Int?) {
        self.maxCounts = maxCounts
        presenter.addButtonEnabled(validateValues())
    }

    func updateCurrentCount(_ currentCount: Int?) {
        self.currentCounts = currentCount
        presenter.addButtonEnabled(validateValues())
    }

    func addAction() {
        guard let maxCounts, let currentCounts else {
            presenter.errorDuringOperation(error: .errorDuringRequest)
            return
        }

        let action = NewCountableAction(title: actionName, maxRepeates: maxCounts, currentRepeats: currentCounts)

        Task {
            if let _ = await networkService.addAction(newAction: action) {
                presenter.addedAction()
            }
            else { presenter.errorDuringOperation(error: .errorDuringRequest) }
        }
    }

    private func validateValues() -> Bool {
        guard let maxCounts,
              let currentCounts else { return false }
        return !actionName.isEmpty && maxCounts > 0 && currentCounts <= maxCounts
    }
}
