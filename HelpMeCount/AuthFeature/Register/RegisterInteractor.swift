//
//  RegisterInteractor.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 18.12.2025.
//

import Foundation

class RegisterInteractor {

    private let presenter: RegisterPresenter
    private let networkService: NetworkService
    private let dbService: LocalDataStorage

    private var userLogin: String = ""
    private var password: String = ""

    init(presenter: RegisterPresenter, networkService: NetworkService, dbService: LocalDataStorage) {
        self.presenter = presenter
        self.networkService = networkService
        self.dbService = dbService
    }

    func register() {
        presenter.setIsLoadingStatus(isLoading: true)
        defer { presenter.setIsLoadingStatus(isLoading: false) }
        
        Task {
            let registerResult = await networkService.registerRequest(
                login: userLogin,
                password: password)

            switch registerResult {
            case .success(let tokenData):
                await dbService.saveLoggedUser(tokenData) == nil
                ? presenter.setRegisterResult(success: false)
                : presenter.setRegisterResult(success: true)
            case .failure:
                presenter.setRegisterResult(success: false)
            }
        }
    }

    func back() {
        
    }

    func updateLogin(newLogin: String) {
        self.userLogin = newLogin
        updateFieldsState()
    }

    func updatePassword(newPassword: String) {
        self.password = newPassword
        updateFieldsState()
    }

    private func updateFieldsState() {
        //validation
        presenter.setRegisterButtonEnabled(isEnabled: !userLogin.isEmpty && !password.isEmpty)
    }
}
