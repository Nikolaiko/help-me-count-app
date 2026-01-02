//
//  AuthRouter.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 31.12.2025.
//

import UIKit

protocol AuthRouter {
    func goToRegister(parent: UINavigationController) throws
    func backToLogin(parent: UINavigationController)
}
