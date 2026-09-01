//
//  CreateActionInteractor.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 18.02.2026.
//

import Foundation

class CreateActionInteractor: AddActionInteractor, AddActionDataStore {
    private let presenter: AddActionPresenter
    private let worker: AddActionWorker

    private var newActionName: String?
    private var newActionMaxCount: Int?
    private var newActionCurrentCount: Int?

    var createdAt: Date?

    init(presenter: AddActionPresenter, worker: AddActionWorker) {
        self.presenter = presenter
        self.worker = worker
    }

    func createNewAction() {
        Task {
            let result = await worker.create(action: NewCountableAction(
                title: newActionName ?? "",
                maxRepeats: newActionMaxCount ?? 0,
                currentRepeats: newActionCurrentCount ?? 0))
            switch result {
            case .success(let newAction):
                worker.cache(action: newAction)
                presenter.newActionAdded()
            case .failure:
                print("Error")
            }
        }
    }

    func updateActionName(name: String) {
        newActionName = name
        presenter.setAddButtonEnabled(enabled: validate())
    }

    func updateMaxCount(count: Int?) {
        newActionMaxCount = count
        presenter.setAddButtonEnabled(enabled: validate())
    }

    func updateCurrentCount(count: Int?) {
        newActionCurrentCount = count
        presenter.setAddButtonEnabled(enabled: validate())
    }

    private func validate() -> Bool {
        guard let newActionName,
              let newActionMaxCount,
              let newActionCurrentCount
        else { return false }
        
        return !newActionName.isEmpty && newActionMaxCount > 0 && newActionCurrentCount >= 0 && newActionCurrentCount <= newActionMaxCount
    }
}
