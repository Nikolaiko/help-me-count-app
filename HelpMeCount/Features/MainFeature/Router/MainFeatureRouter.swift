//
//  MainFeatureRouter.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 26.01.2026.
//

import UIKit

protocol MainFeatureRouter {
    func routeToAddAction(parent: UINavigationController)
    func routeToLogin(parent: UINavigationController)
    func routeBackFromAddAction(parent: UINavigationController)
}
