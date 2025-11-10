//
//  LoginInteractor.swift
//  TrainingSessions
//
//  Created by Yakov on 23.10.2025.
//

import Foundation

class LoginInteractor {
    
    private let presenter: LoginPresenter
    private let networkService: NetworkService
    private let dbService: LocalDataStorage

    init(presenter: LoginPresenter, networkService: NetworkService, storage: LocalDataStorage) {
        self.presenter = presenter
        self.networkService = networkService
        self.dbService = storage
    }
    
    func login(username: String, password: String) -> Void {
        Task {
            if let token = await networkService.loginRequest(login: username, password: password),
               let savedtoken = dbService.saveLoggedUser(DBToken(token: token.token)) {
                presenter.loginResult(result: true)
            } else {
                presenter.loginResult(result: false)
            }
        }
    }

    func register(username: String, password: String) -> Void {
        Task {
            if let token = await networkService.registerRequest(login: username, password: password),
               let savedtoken = dbService.saveLoggedUser(DBToken(token: token.token)) {
                presenter.loginResult(result: true)
            } else {
                presenter.loginResult(result: false)
            }
        }
    }
}
