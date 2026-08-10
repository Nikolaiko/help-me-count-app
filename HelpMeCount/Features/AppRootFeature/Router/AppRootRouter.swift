//
//  File.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 29.12.2025.
//

import UIKit

protocol AppRootRouter {
    func routeToLogin(parent: UINavigationController) throws
    func routeToAuthorized(parent: UINavigationController) throws
}
