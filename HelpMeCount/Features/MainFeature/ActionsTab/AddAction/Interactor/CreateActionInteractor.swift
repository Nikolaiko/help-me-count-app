//
//  CreateActionInteractor.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 18.02.2026.
//

import Foundation

class CreateActionInteractor: AddActionInteractor {
    private let presenter: AddActionPresenter
    private let networkService: NetworkService
    private let localDataStorage: LocalActionsStorage

    private var newActionName: String?
    private var newActionMaxCount: Int?
    private var newActionCurrentCount: Int?

    init(presenter: AddActionPresenter,
         networkService: NetworkService,
         localDataStorage: LocalActionsStorage) {
        self.presenter = presenter
        self.networkService = networkService
        self.localDataStorage = localDataStorage
    }

    func createNewAction() {
        Task {
            let result = await networkService.addNewAction(action: NewCountableAction(
                title: newActionName ?? "",
                maxRepeats: newActionMaxCount ?? 0,
                currentRepeats: newActionCurrentCount ?? 0))
            switch result {
            case .success(let newAction):
                localDataStorage.addNewAction(action: newAction)
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
