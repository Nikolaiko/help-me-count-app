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

    func updateLogin(request: UpdateLogin.Request) {
        self.login = request.value
        self.presenter.setLoginEnabled(response: ValidateLoginForm.Response(isEnabled: validateInput()))
    }

    func updatePassword(request: UpdatePassword.Request) {
        self.password = request.value
        self.presenter.setLoginEnabled(response: ValidateLoginForm.Response(isEnabled: validateInput()))
    }

    func loginUser() {
        presenter.hideErrorText()
        presenter.setIsLoading(response: SetLoginLoading.Response(isLoading: true))

        Task {
            defer { presenter.setIsLoading(response: SetLoginLoading.Response(isLoading: false)) }
            let result = await networkService.loginUser(login: login, password: password)
            switch result {
            case .success(let token):
                guard let savedToken = localStorage.saveUserToken(newToken: token)
                else {
                    presenter.showError(response: ShowLoginError.Response(text: "Falied to save token"))
                    return
                }

                presenter.successLogin()
            case .failure(let error):
                presenter.showError(response: ShowLoginError.Response(text: "Login error"))
            }
        }
    }

    private func validateInput() -> Bool {
        !self.login.isEmpty && !self.password.isEmpty
    }
}
