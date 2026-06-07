//
//  ClassicLoginInteractor.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 07.01.2026.
//


import Foundation

class ClassicRegisterInteractor: RegisterInteractor {
    private let presenter: RegisterPresenter
    private let localStorage: LocalTokensStorage
    private let networkService: NetworkService

    private var login: String = ""
    private var password: String = ""


    init(presenter: RegisterPresenter,
         localStorage: LocalTokensStorage,
         networkService: NetworkService) {
        self.presenter = presenter
        self.localStorage = localStorage
        self.networkService = networkService
    }

    func updateLogin(newValue: String) {
        self.login = newValue
        self.presenter.setRegisterEnabled(isEnabled: validateInput())
    }

    func updatePassword(newValue: String) {
        self.password = newValue
        self.presenter.setRegisterEnabled(isEnabled: validateInput())
    }

    func registerUser() {
        presenter.hideErrorText()
        presenter.setIsLoading(isLoading: true)

        Task {
            defer { presenter.setIsLoading(isLoading: false) }
            let result = await networkService.registerUser(login: login, password: password)
            switch result {
            case .success(let token):
                guard let savedToken = localStorage.saveUserToken(newToken: token)
                else {
                    presenter.showError(text: "Falied to save token")
                    return
                }

                presenter.successRegistration()
            case .failure(let error):                
                presenter.showError(text: "Register error")
            }
        }
    }

    private func validateInput() -> Bool {
        !self.login.isEmpty && !self.password.isEmpty
    }
}
