//
//  ClassicLoginPresenter.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 31.12.2025.
//

import Foundation

class ClassicLoginPresenter: LoginPresenter {
    private let view: LoginViewController

    init(view: LoginViewController) {
        self.view = view
    }

    func setLoginEnabled(isEnabled: Bool) {
        view.setLoginEnabled(isEnabled: isEnabled)
    }

    func setIsLoading(isLoading: Bool) {
        view.setIsLoading(isLoading: isLoading)
    }

    func showError(text: String) {
        view.showErrorText(errorText: text)
    }

    func hideErrorText() {
        view.hideError()
    }
}
