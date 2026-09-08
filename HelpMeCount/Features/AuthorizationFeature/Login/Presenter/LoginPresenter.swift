//
//  LoginPresenter.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 31.12.2025.
//

import Foundation

protocol LoginPresenter {
    func setLoginEnabled(response: ValidateLoginForm.Response)
    func setIsLoading(response: SetLoginLoading.Response)
    func successLogin()
    func showError(response: ShowLoginError.Response)
    func hideErrorText()
}
