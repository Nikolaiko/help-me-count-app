//
//  LoginInteractor.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 31.12.2025.
//

import Foundation

protocol LoginInteractor {
    func updateLogin(request: UpdateLogin.Request)
    func updatePassword(request: UpdatePassword.Request)
    func loginUser()
}
