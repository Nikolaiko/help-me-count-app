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

    private var userLogin: String = ""
    private var password: String = ""

    init(presenter: LoginPresenter, networkService: NetworkService, storage: LocalDataStorage) {
        self.presenter = presenter
        self.networkService = networkService
        self.dbService = storage
    }

    func updateLogin(newLogin: String) {
        self.userLogin = newLogin
        updateFieldsState()
    }

    func updatePassword(newPassword: String) {
        self.password = newPassword
        updateFieldsState()
    }

    func login() -> Void {
        presenter.setIsLoading(isLoading: true)
        Task {
            defer { presenter.setIsLoading(isLoading: false) }
            
            if let token = await networkService.loginRequest(
                login: userLogin,
                password: password
            ), await dbService.saveLoggedUser(token) != nil {
                presenter.loginResult(result: true)
            } else {
                presenter.loginResult(result: false)
            }
        }
    }

    func register(username: String, password: String) -> Void {
        Task {
            if let token = await networkService.registerRequest(login: username, password: password),
               let _ = await dbService.saveLoggedUser(token) {
                presenter.loginResult(result: true)
            } else {
                presenter.loginResult(result: false)
            }
        }
    }

    private func updateFieldsState() {
        //validation
        presenter.setLoginButtonEnabled(isEnabled: !userLogin.isEmpty && !password.isEmpty)
    }
}
