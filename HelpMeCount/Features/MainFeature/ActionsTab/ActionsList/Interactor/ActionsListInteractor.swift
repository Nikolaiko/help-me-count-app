//
//  ActionListInteractor.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 15.03.2026.
//

import Foundation

protocol ActionsListInteractor: ActionsListDateProvider & ActionsListMessageReceiver {
    func initSubscriptions()
    func resfreshActionsList()
    func addActionRepetition(request: AddActionRepetition.Request)
}

protocol ActionsListMessageReceiver {
    var message: String? { get set }
}
