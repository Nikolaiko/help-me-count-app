//
//  LoginInteractor.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 07.01.2026.
//


import Foundation

protocol RegisterInteractor {
    func updateLogin(newValue: String)
    func updatePassword(newValue: String)
    func registerUser()
}
