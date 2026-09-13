//
//  ProfileView.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 15.08.2026.
//

import Foundation

protocol ProfileView: NavigatableView {
    var interactor: ProfileInteractor? { get set }
    var router: ProfileRouter? { get set }

    func showLogoutConfirmation()
    func returnToLoginScreen()
}
