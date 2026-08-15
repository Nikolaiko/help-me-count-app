//
//  ProfileView.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 15.08.2026.
//

import Foundation

protocol ProfileView: AnyObject {
    var interactor: ProfileInteractor? { get set }
    var router: MainFeatureRouter? { get set }

    func showLogoutConfirmation()
    func returnToLoginScreen()
}
