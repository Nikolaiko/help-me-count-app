//
//  LoginPresenter.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 07.01.2026.
//


import Foundation

protocol RegisterPresenter {
    func setRegisterEnabled(isEnabled: Bool)
    func setIsLoading(isLoading: Bool)
    func showError(text: String)
    func hideErrorText()
    func successRegistration()
}
