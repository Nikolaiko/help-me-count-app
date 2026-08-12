//
//  ActionsWorker.swift
//  HelpMeCount
//
//  Worker сцены ActionsList: сеть (список/инкремент) + локальный кэш действий.
//  Вся бизнес-логика (пересчёт повторений и т.п.) остаётся в Interactor'е.
//

import Foundation
import Combine

protocol ActionsWorker {
    var changesPublisher: any Publisher<Notification, Never> { get }

    func fetchActions() async -> Result<[CountableAction], NetworkError>
    func increaseCount(action: CountableAction) async -> Result<CountableAction, NetworkError>

    func cachedActions() -> [CountableAction]
    func cacheActions(_ actions: [CountableAction])
    func update(action: CountableAction)
}

final class ActionsTabWorker: ActionsWorker {
    private let networkLayer: NetworkService
    private let actionsStorage: LocalActionsStorage

    init(networkLayer: NetworkService, actionsStorage: LocalActionsStorage) {
        self.networkLayer = networkLayer
        self.actionsStorage = actionsStorage
    }

    var changesPublisher: any Publisher<Notification, Never> {
        actionsStorage.contextPublisher
    }

    func fetchActions() async -> Result<[CountableAction], NetworkError> {
        await networkLayer.getActions()
    }

    func increaseCount(action: CountableAction) async -> Result<CountableAction, NetworkError> {
        await networkLayer.increaseActionCount(action: action)
    }

    func cachedActions() -> [CountableAction] {
        actionsStorage.getActionsList()
    }

    func cacheActions(_ actions: [CountableAction]) {
        actionsStorage.refreshActions(actions: actions)
    }

    func update(action: CountableAction) {
        actionsStorage.updateAction(action: action)
    }
}
