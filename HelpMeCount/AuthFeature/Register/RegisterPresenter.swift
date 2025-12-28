//
//  RegisterPresenter.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 18.12.2025.
//

import Foundation

class RegisterPresenter {

    private let view: RegisterViewController

    init(view: RegisterViewController) {
        self.view = view
    }

    public func setRegisterResult(success: Bool) {
        view.onRegisterResult(success: success)
    }

    public func setRegisterButtonEnabled(isEnabled: Bool) {
        view.setRegisterButtonEnabled(isEnabled: isEnabled)
    }

    public func setIsLoadingStatus(isLoading: Bool) {
        view.setIsLoginStatus(isLoading: isLoading)
    }
}
