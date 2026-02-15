//
//  SwiftDataStorage.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 09.11.2025.
//

import Foundation
import SwiftData
import Combine

final class SwiftDataStorage: LocalDataStorage {

    private let localDataActor: SwiftModelActor
    private var eventsSubscription: AnyCancellable?

    weak var delegate: DBUpdateListener?

    init() {
        let configuration = ModelConfiguration(            
            isStoredInMemoryOnly: false
        )
        let container = try! ModelContainer(
            for: DBUserToken.self,
            migrationPlan: Migrations.self,
            configurations: configuration)
        localDataActor = SwiftModelActor(modelContainer: container)
    }

    func subscribeToUpdates() {
        eventsSubscription =  NotificationCenter.default.publisher(
            for: ModelContext.didSave)
        .sink { [weak self] notification in
            guard let self,
                  let delegate = self.delegate else { return }            
            delegate.databaseUpdated()
        }
    }

    func getLoggedUser() async -> TokenData? {
        await localDataActor.fetchTokenData()
    }

    func saveLoggedUser(_ token: TokenData) async -> TokenData? {
        guard let _ = try? await localDataActor.saveTokenData(token: token)
        else { return nil }

        delegate?.databaseUpdated()
        return token
    }

    deinit {
        eventsSubscription?.cancel()
    }
}
