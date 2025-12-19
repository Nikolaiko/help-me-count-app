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
        //presenter.setLoginButtonEnabled(isEnabled: !userLogin.isEmpty && !password.isEmpty)
    }
}
