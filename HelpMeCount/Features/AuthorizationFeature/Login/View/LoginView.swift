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

    func setLoginEnabled(viewData: ValidateLoginForm.ViewData)
    func setIsLoading(viewData: SetLoginLoading.ViewData)
    func showErrorText(viewData: ShowLoginError.ViewData)
    func hideError()
    func successLogin()
}
