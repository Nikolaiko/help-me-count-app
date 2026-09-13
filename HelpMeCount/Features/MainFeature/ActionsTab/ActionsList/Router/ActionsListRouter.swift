//
//  ActionsListRouter.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 15.08.2026.
//

import Foundation

protocol ActionsListRouter {
    func navigateToAddAction() throws
}

protocol ActionsListDateProvider {
    func currentDate() -> Date
}
