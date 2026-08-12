//
//  AddActionWorker.swift
//  HelpMeCount
//
//  Worker сцены AddAction: создание действия в сети + запись в локальный кэш.
//

import Foundation

protocol AddActionWorker {
    func create(action: NewCountableAction) async -> Result<CountableAction, NetworkError>
    func cache(action: CountableAction)
}

final class CreateActionWorker: AddActionWorker {
    private let networkService: NetworkService
    private let localDataStorage: LocalActionsStorage

    init(networkService: NetworkService, localDataStorage: LocalActionsStorage) {
        self.networkService = networkService
        self.localDataStorage = localDataStorage
    }

    func create(action: NewCountableAction) async -> Result<CountableAction, NetworkError> {
        await networkService.addNewAction(action: action)
    }

    func cache(action: CountableAction) {
        localDataStorage.addNewAction(action: action)
    }
}
