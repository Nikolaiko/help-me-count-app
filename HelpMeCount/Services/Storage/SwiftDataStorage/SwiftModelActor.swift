//
//  SwiftModelActor.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 04.02.2026.
//

import Foundation
import SwiftData

final actor SwiftModelActor {
    private let modelExecutor: any ModelExecutor
    private let modelContainer: ModelContainer
    private var modelContext: ModelContext { modelExecutor.modelContext }

    init(modelContainer: ModelContainer) {
        self.modelExecutor = DefaultSerialModelExecutor(
            modelContext: ModelContext(modelContainer))
        self.modelContainer = modelContainer
    }

    func saveTokenData(token: TokenData) async throws {
        if let alreadyLoggedToken = getLoggedDataFromDb() {
            alreadyLoggedToken.token = token.token
        } else {
            modelContext.insert(token.toDBToken())
        }

        do { try modelContext.save() }
        catch {
            modelContext.rollback()
            throw LocalDataError.failedToSaveEntity
        }
    }

    func fetchTokenData() async -> TokenData? {
        getLoggedDataFromDb()?.toTokenData()
    }

    private func getLoggedDataFromDb() -> DBUserToken? {
        let descriptor = FetchDescriptor<DBUserToken>()
        return try? modelContext.fetch(descriptor).first
    }
}
