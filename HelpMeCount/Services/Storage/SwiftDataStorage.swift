//
//  SwiftDataStorage.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 09.11.2025.
//

import Foundation
import SwiftData

final class SwiftDataStorage {

    private var container: ModelContainer?
    private var context: ModelContext?

    init() {
        let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
        if let container = try? ModelContainer(for: DBUserToken.self, configurations: configuration) {
            self.container = container
            self.context = ModelContext(container)
        }
    }

    func getLoggedUser() -> DBUserToken? {
        let descriptor = FetchDescriptor<DBUserToken>()
        return try? context?.fetch(descriptor).first
    }

    func saveLoggedUser(_ token: DBUserToken) -> DBUserToken? {
        if let alreadyLoggedToken = getLoggedUser() {
            alreadyLoggedToken.token = token.token
            guard let result = try? context?.save() else { return nil }
        } else {
            context?.insert(token)
            guard context?.insertedModelsArray.contains(where: { $0.id == token.id }) ?? false
            else { return nil }
        }
        return token
    }
}
