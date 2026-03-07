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

            let loginResult = await networkService.loginRequest(
                login: userLogin,
                password: password)

            switch loginResult {
            case .success(let tokenData):
                await dbService.saveLoggedUser(tokenData) == nil
                    ? presenter.loginResult(result: false)
                    : presenter.loginResult(result: true)
            case .failure:
                presenter.loginResult(result: false)
            }
        }
    }

    private func updateFieldsState() {
        //validation
        presenter.setLoginButtonEnabled(isEnabled: !userLogin.isEmpty && !password.isEmpty)
    }
}
