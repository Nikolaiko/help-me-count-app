//
//  RegisterWorker.swift
//  HelpMeCount
//
//  Worker сцены Register: регистрация в сети + сохранение токена.
//

import Foundation

protocol RegisterWorker {
    func register(login: String, password: String) async -> Result<UserToken, NetworkError>
    func persist(token: UserToken) -> UserToken?
}

final class ClassicRegisterWorker: RegisterWorker {
    private let networkService: NetworkService
    private let tokensStorage: LocalTokensStorage

    init(networkService: NetworkService, tokensStorage: LocalTokensStorage) {
        self.networkService = networkService
        self.tokensStorage = tokensStorage
    }

    func register(login: String, password: String) async -> Result<UserToken, NetworkError> {
        await networkService.registerUser(login: login, password: password)
    }

    func persist(token: UserToken) -> UserToken? {
        tokensStorage.saveUserToken(newToken: token)
    }
}
