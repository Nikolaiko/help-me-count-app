//
//  ClassicLoginInteractor.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 31.12.2025.
//

import Foundation

class ClassicLoginInteractor: LoginInteractor, LoginDataStore {
    private let presenter: LoginPresenter
    private let worker: LoginWorker

    private var login: String = ""
    private var password: String = ""


    init(presenter: LoginPresenter, worker: LoginWorker) {
        self.presenter = presenter
        self.worker = worker
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
            let result = await worker.login(login: login, password: password)
            switch result {
            case .success(let token):
                guard worker.persist(token: token) != nil
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
