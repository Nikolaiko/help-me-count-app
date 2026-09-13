//
//  RegistrationController.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 15.08.2026.
//

import Foundation

protocol RegistrationController: NavigatableView {
    var router: AuthRouter? { get set }
    var interactor: RegisterInteractor? { get set }

    func setLoginEnabled(viewData: ValidateRegisterForm.ViewData)
    func setIsLoading(viewData: SetRegisterLoading.ViewData)
    func showErrorText(viewData: ShowRegisterError.ViewData)
    func hideError()
    func successRegister()
}
