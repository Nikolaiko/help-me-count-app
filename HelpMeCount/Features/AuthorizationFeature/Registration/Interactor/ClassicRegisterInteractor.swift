//
//  ClassicLoginInteractor.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 07.01.2026.
//


import Foundation

class ClassicRegisterInteractor: RegisterInteractor {
    private let presenter: RegisterPresenter
    private let localStorage: LocalStorageService
    private let networkService: NetworkService

    private var login: String = ""
    private var password: String = ""


    init(presenter: RegisterPresenter,
         localStorage: LocalStorageService,
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
            if let token = await networkService.registerUser(login: login, password: password),
               let savedToken = localStorage.saveUserToken(newToken: token) {
                presenter.successRegistration()
            } else {
                presenter.showError(text: "Register Failed")
            }
        }
    }

    private func validateInput() -> Bool {
        !self.login.isEmpty && !self.password.isEmpty
    }
}
