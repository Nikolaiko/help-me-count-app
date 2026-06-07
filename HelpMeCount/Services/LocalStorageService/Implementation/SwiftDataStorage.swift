//
//  SwiftDataStorage.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 23.03.2026.
//

import Foundation
import SwiftData
import Combine

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

    func updateAction(action: CountableAction) {
        var description = FetchDescriptor<DBCountableAction>(
            predicate: #Predicate { $0.id == action.id }
        )
        description.fetchLimit = 1

        if let dbAction = try? context.fetch(description).first {
            dbAction.currentRepeats = action.currentRepeats
            try? context.save()
        }
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

    func removeAllActions() {
        do {
            try context.delete(model: DBCountableAction.self)
            try context.save()
        } catch {
            print("Failed to clear data: \(error.localizedDescription)")
        }
    }
}
