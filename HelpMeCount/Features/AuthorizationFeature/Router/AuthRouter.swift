//
//  AuthRouter.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 31.12.2025.
//

import UIKit

protocol AuthRouter {
    func goToAuthorizedScreen() throws
    func goToRegister() throws
    func backToLogin() throws
}
