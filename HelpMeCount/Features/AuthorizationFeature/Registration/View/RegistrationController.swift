//
//  RegistrationController.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 15.08.2026.
//

import Foundation

protocol RegistrationController: AnyObject {
    var router: AuthRouter? { get set }
    var interactor: RegisterInteractor? { get set }

    func setLoginEnabled(isEnabled: Bool)
    func setIsLoading(isLoading: Bool)
    func showErrorText(errorText: String)
    func hideError()
    func successRegister()
}
