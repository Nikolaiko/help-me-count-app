//
//  ClassicLoginPresenter.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 31.12.2025.
//

import Foundation

class ClassicLoginPresenter: LoginPresenter {
    private weak var view: LoginView?

    init(view: LoginView) {
        self.view = view
    }

    func setLoginEnabled(response: ValidateLoginForm.Response) {
        view?.setLoginEnabled(viewData: ValidateLoginForm.ViewData(isEnabled: response.isEnabled))
    }

    func setIsLoading(response: SetLoginLoading.Response) {
        view?.setIsLoading(viewData: SetLoginLoading.ViewData(isLoading: response.isLoading))
    }

    func showError(response: ShowLoginError.Response) {
        view?.showErrorText(viewData: ShowLoginError.ViewData(text: response.text))
    }

    func hideErrorText() {
        view?.hideError()
    }

    func successLogin() {
        view?.successLogin()
    }
}
