//
//  LocalActionsStorage.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 23.03.2026.
//

import Foundation
import Combine
import SwiftData

protocol LocalActionsStorage {
    var contextPublisher: any Publisher<Notification, Never> { get }

    func updateAction(action: CountableAction)
    func addNewAction(action: CountableAction)
    func refreshActions(actions: [CountableAction])
    func getActionsList() -> [CountableAction]
    func removeAllActions()
}
