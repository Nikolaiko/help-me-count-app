//
//  MainFeatureRouter.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 26.01.2026.
//

import UIKit

protocol MainFeatureRouter {
    func navigateToAddAction(parent: UINavigationController) throws
    func backFromAddAction(parent: UINavigationController)
}
