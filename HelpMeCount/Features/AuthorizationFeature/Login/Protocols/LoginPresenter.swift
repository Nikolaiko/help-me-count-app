//
//  LoginPresenter.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 31.12.2025.
//

import Foundation

protocol LoginPresenter {
    func setLoginEnabled(isEnabled: Bool)
    func setIsLoading(isLoading: Bool)
    func successLogin()
    func showError(text: String)
    func hideErrorText()
}
