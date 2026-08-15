//
//  ClassicLoginPresenter.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 07.01.2026.
//


import Foundation

class ClassicRegisterPresenter: RegisterPresenter {
    private weak var view: RegistrationController?

    init(view: RegistrationController) {
        self.view = view
    }

    func setRegisterEnabled(isEnabled: Bool) {
        view?.setLoginEnabled(isEnabled: isEnabled)
    }

    func setIsLoading(isLoading: Bool) {
        view?.setIsLoading(isLoading: isLoading)
    }

    func showError(text: String) {
        view?.showErrorText(errorText: text)
    }

    func hideErrorText() {
        view?.hideError()
    }

    func successRegistration() {
        view?.successRegister()
    }
}
