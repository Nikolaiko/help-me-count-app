//
//  ClassicLoginInteractor.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 31.12.2025.
//

import Foundation

class ClassicLoginInteractor: LoginInteractor {
    private let presenter: LoginPresenter
    private let localStorage: LocalTokensStorage
    private let networkService: NetworkService

    private var login: String = ""
    private var password: String = ""


    init(presenter: LoginPresenter,
         localStorage: LocalTokensStorage,
         networkService: NetworkService) {
        self.presenter = presenter
        self.localStorage = localStorage
        self.networkService = networkService
    }

    func updateLogin(newValue: String) {
        self.login = newValue
        self.presenter.setLoginEnabled(isEnabled: validateInput())
    }

    func updatePassword(newValue: String) {
        self.password = newValue
        self.presenter.setLoginEnabled(isEnabled: validateInput())
    }

    func loginUser() {
        presenter.hideErrorText()
        presenter.setIsLoading(isLoading: true)

        Task {
            defer { presenter.setIsLoading(isLoading: false) }
            let result = await networkService.loginUser(login: login, password: password)
            switch result {
            case .success(let token):
                guard let savedToken = localStorage.saveUserToken(newToken: token)
                else {
                    presenter.showError(text: "Falied to save token")
                    return
                }

                presenter.successLogin()
            case .failure(let error):                
                presenter.showError(text: "Login error")
            }
        }
    }

    private func validateInput() -> Bool {
        !self.login.isEmpty && !self.password.isEmpty
    }
}
