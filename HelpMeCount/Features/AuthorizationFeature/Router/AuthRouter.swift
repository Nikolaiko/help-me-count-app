//
//  AuthRouter.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 31.12.2025.
//

import UIKit

protocol AuthRouter {
    func routeToAuthorized(parent: UINavigationController)
    func routeToRegister(parent: UINavigationController)
    func routeBackToLogin(parent: UINavigationController)
}
