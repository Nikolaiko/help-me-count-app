//
//  LoginView.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 14.08.2026.
//

import Foundation

protocol LoginView: AnyObject {
    var interactor: LoginInteractor? { get set }
    var router: AuthRouter? { get set }

    func setLoginEnabled(isEnabled: Bool)
    func setIsLoading(isLoading: Bool)
    func showErrorText(errorText: String)
    func hideError()
    func successLogin()
}
