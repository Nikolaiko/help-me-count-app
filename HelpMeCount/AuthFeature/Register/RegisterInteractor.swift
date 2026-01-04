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

        Task {
            defer { presenter.setIsLoadingStatus(isLoading: false) }

            if let result = await networkService.registerRequest(login: userLogin,
                                                                 password: password),
               let savedToken = dbService.saveLoggedUser(TokenData(token: result.token, refreshToken: result.refreshToken)){
                presenter.setRegisterResult(success: true)
            } else {
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
