//
//  LoginPresenter.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 07.01.2026.
//


import Foundation

protocol RegisterPresenter {
    func setRegisterEnabled(response: ValidateRegisterForm.Response)
    func setIsLoading(response: SetRegisterLoading.Response)
    func showError(response: ShowRegisterError.Response)
    func hideErrorText()
    func successRegistration()
}
