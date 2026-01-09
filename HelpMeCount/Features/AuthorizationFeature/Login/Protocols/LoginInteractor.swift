//
//  LoginInteractor.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 31.12.2025.
//

import Foundation

protocol LoginInteractor {
    func updateLogin(newValue: String)
    func updatePassword(newValue: String)
    func loginUser()
}
