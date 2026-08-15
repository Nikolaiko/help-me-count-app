//
//  ServiceFactory.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 15.08.2026.
//

import Foundation

final class ServiceFactory {
    let tokenStorage: LocalTokensStorage
    let actionStorage: LocalActionsStorage
    let api: NetworkService

    init() {
        tokenStorage = UserDefaultsStorage()
        actionStorage = SwiftDataStorage()
        api = GeneratedAPI(localService: tokenStorage)
    }
}
