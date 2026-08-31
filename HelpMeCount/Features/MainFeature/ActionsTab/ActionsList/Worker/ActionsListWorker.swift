//
//  ActionsListWorker.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 30.08.2026.
//

import Foundation
import SwiftData
import Combine

protocol ListWorker {
    var contextPublisher: any Publisher<Notification, Never> { get }

    func getActionsList() -> [CountableAction]
    func updateAction(action: CountableAction)
    func refreshActions(actions: [CountableAction])

    func getActions() async -> Result<[CountableAction], NetworkError>
    func increaseActionCount(action: CountableAction) async -> Result<CountableAction, NetworkError>
}

struct ActionsListWorker: ListWorker {

    var contextPublisher: any Publisher<Notification, Never> {
        actionsStorage.contextPublisher
    }

    private let networkService: NetworkService
    private let actionsStorage: LocalActionsStorage

    init(networkService: NetworkService, actionsStorage: LocalActionsStorage) {
        self.networkService = networkService
        self.actionsStorage = actionsStorage
    }

    func getActionsList() -> [CountableAction] {
        actionsStorage.getActionsList()
    }

    func updateAction(action: CountableAction) {
        actionsStorage.updateAction(action: action)
    }

    func refreshActions(actions: [CountableAction]) {
        actionsStorage.refreshActions(actions: actions)
    }

    func getActions() async -> Result<[CountableAction], NetworkError> {
        await networkService.getActions()
    }

    func increaseActionCount(action: CountableAction) async -> Result<CountableAction, NetworkError> {
        await networkService.increaseActionCount(action: action)
    }
}
