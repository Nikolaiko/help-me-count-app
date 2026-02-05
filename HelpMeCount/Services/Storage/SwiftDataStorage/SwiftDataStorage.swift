//
//  SwiftDataStorage.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 09.11.2025.
//

import Foundation
import SwiftData

final class SwiftDataStorage: LocalDataStorage {

    private let localDataActor: SwiftModelActor

    init() {
        let configuration = ModelConfiguration(isStoredInMemoryOnly: false)
        let container = try! ModelContainer(
            for: DBUserToken.self,
            configurations: configuration)
        localDataActor = SwiftModelActor(modelContainer: container)
    }

    func getLoggedUser() async -> TokenData? {
        await localDataActor.fetchTokenData()
    }

    func saveLoggedUser(_ token: TokenData) async -> TokenData? {
        guard let _ = try? await localDataActor.saveTokenData(token: token)
        else { return nil }
        return token
    }
}
