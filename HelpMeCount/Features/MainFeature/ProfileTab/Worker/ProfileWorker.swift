//
//  ProfileWorker.swift
//  HelpMeCount
//
//  Worker сцены Profile: полная очистка данных пользователя (действия + токен).
//

import Foundation

protocol ProfileWorker {
    func clearAllData()
}

final class ProfileTabWorker: ProfileWorker {
    private let tokenStorage: LocalTokensStorage
    private let actionsStorage: LocalActionsStorage

    init(tokenStorage: LocalTokensStorage, actionsStorage: LocalActionsStorage) {
        self.tokenStorage = tokenStorage
        self.actionsStorage = actionsStorage
    }

    func clearAllData() {
        actionsStorage.removeAllActions()
        tokenStorage.removeToken()
    }
}
