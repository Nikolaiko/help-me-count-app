//
//  LoginInteractor.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 07.01.2026.
//


import Foundation

protocol RegisterInteractor {
    func updateLogin(request: UpdateRegisterLogin.Request)
    func updatePassword(request: UpdateRegisterPassword.Request)
    func registerUser()
}
