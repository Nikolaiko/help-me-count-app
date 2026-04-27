//
//  SwiftDataStorage.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 23.03.2026.
//

import Foundation
import SwiftData
import Combine

enum Version1: VersionedSchema {
    static var models: [any PersistentModel.Type] {
        [DBCountableAction.self]
    }

    static var versionIdentifier = Schema.Version(1, 0, 0)
}

final class SwiftDataStorage: LocalActionsStorage {

    public let contextPublisher: any Publisher<Notification, Never>

    private let context: ModelContext

    init() {
        let configuration = ModelConfiguration(isStoredInMemoryOnly: false)
        let container = try! ModelContainer(
            for: DBCountableAction.self,
            configurations: configuration)
        context = ModelContext(container)

        contextPublisher = NotificationCenter.default.publisher(for: ModelContext.didSave).eraseToAnyPublisher()
    }

    func refreshActions(actions: [CountableAction]) {
        do {
            try context.delete(model: DBCountableAction.self)
            for action in actions {
                context.insert(action.toDBAction())
            }
            try context.save()
        } catch {
            print("save error")
        }
    }

    func addNewAction(action: CountableAction) {
        do {
            context.insert(action.toDBAction())
            try context.save()
        } catch {
            print("Save action error")
        }
    }

    func getActionsList() -> [CountableAction] {
        let descriptor = FetchDescriptor<DBCountableAction>()
        let actions = (try? context.fetch(descriptor)) ?? []

        return actions.map { $0.toCountableAction() }
    }
}
