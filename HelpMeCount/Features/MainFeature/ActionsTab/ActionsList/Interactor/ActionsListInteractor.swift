//
//  ActionListInteractor.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 15.03.2026.
//

import Foundation

protocol ActionsListInteractor {
    func initSubscriptions()
    func resfreshActionsList()
    func addActionRepetition(action: CountableAction)
}
