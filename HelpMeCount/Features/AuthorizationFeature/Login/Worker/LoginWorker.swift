//
//  LoginWorker.swift
//  HelpMeCount
//
//  Worker сцены Login: аутентификация в сети + сохранение токена.
//

import Foundation

protocol LoginWorker {
    func login(login: String, password: String) async -> Result<UserToken, NetworkError>
    func persist(token: UserToken) -> UserToken?
}

final class ClassicLoginWorker: LoginWorker {
    private let networkService: NetworkService
    private let tokensStorage: LocalTokensStorage

    init(networkService: NetworkService, tokensStorage: LocalTokensStorage) {
        self.networkService = networkService
        self.tokensStorage = tokensStorage
    }

    func login(login: String, password: String) async -> Result<UserToken, NetworkError> {
        await networkService.loginUser(login: login, password: password)
    }

    func persist(token: UserToken) -> UserToken? {
        tokensStorage.saveUserToken(newToken: token)
    }
}
