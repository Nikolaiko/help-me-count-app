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

    func setRegisterEnabled(response: ValidateRegisterForm.Response) {
        view?.setLoginEnabled(viewData: ValidateRegisterForm.ViewData(isEnabled: response.isEnabled))
    }

    func setIsLoading(response: SetRegisterLoading.Response) {
        view?.setIsLoading(viewData: SetRegisterLoading.ViewData(isLoading: response.isLoading))
    }

    func showError(response: ShowRegisterError.Response) {
        view?.showErrorText(viewData: ShowRegisterError.ViewData(text: response.text))
    }

    func hideErrorText() {
        view?.hideError()
    }

    func successRegistration() {
        view?.successRegister()
    }
}
