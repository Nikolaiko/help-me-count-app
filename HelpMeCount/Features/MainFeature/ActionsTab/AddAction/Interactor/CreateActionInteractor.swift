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

    private var currentDate: Date?

    var passedDate: Date {
        get { currentDate ?? Date() }
        set { currentDate = newValue }
    }

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

    func updateActionName(request: UpdateActionName.Request) {
        newActionName = request.name
        presenter.setAddButtonEnabled(response: ValidateNewAction.Response(enabled: validate()))
    }

    func updateMaxCount(request: UpdateMaxCount.Request) {
        newActionMaxCount = request.count
        presenter.setAddButtonEnabled(response: ValidateNewAction.Response(enabled: validate()))
    }

    func updateCurrentCount(request: UpdateCurrentCount.Request) {
        newActionCurrentCount = request.count
        presenter.setAddButtonEnabled(response: ValidateNewAction.Response(enabled: validate()))
    }

    private func validate() -> Bool {
        guard let newActionName,
              let newActionMaxCount,
              let newActionCurrentCount
        else { return false }
        
        return !newActionName.isEmpty && newActionMaxCount > 0 && newActionCurrentCount >= 0 && newActionCurrentCount <= newActionMaxCount
    }
}
