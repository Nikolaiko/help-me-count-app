//
//  AppRootWorker.swift
//  HelpMeCount
//
//  Worker сцены AppRoot: инкапсулирует работу с хранилищем токена.
//  Interactor обращается к Worker'у, а не к сервису напрямую (канон Clean Swift).
//

import Foundation

protocol AppRootWorker {
    func isUserLoggedIn() -> Bool
}

final class AppRootTokenWorker: AppRootWorker {
    private let tokensStorage: LocalTokensStorage

    init(tokensStorage: LocalTokensStorage) {
        self.tokensStorage = tokensStorage
    }

    func isUserLoggedIn() -> Bool {
        tokensStorage.getUserToken() != nil
    }
}
