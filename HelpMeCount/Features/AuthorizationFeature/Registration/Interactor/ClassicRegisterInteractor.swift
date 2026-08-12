//
//  ClassicLoginInteractor.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 07.01.2026.
//


import Foundation

class ClassicRegisterInteractor: RegisterInteractor {
    private let presenter: RegisterPresenter
    private let worker: RegisterWorker

    private var login: String = ""
    private var password: String = ""


    init(presenter: RegisterPresenter, worker: RegisterWorker) {
        self.presenter = presenter
        self.worker = worker
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
            let result = await worker.register(login: login, password: password)
            switch result {
            case .success(let token):
                guard worker.persist(token: token) != nil
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
