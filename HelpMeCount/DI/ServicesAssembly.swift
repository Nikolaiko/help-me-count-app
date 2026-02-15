//
//  ServicesAssembly.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 02.01.2026.
//

import Foundation
import Swinject

final class ServicesAssembly: Assembly {

    func assemble(container: Container) {
        registerLocalStorage(container: container)
        registerNetworkLayer(container: container)
    }

    func loaded(resolver: any Resolver) {
        let swiftDataStorage = resolver.resolve(
            LocalDataStorage.self,
            name: DIName.swiftDataStorage)! as! SwiftDataStorage

        swiftDataStorage.subscribeToUpdates()
    }

    private func registerNetworkLayer(container: Container) {
        container.register(
            NetworkService.self,
            name: DIName.basicNetworkLayer) { resolver in

                AppNetworkService()
            }

        container.register(
            NetworkService.self,
            name: DIName.generatedNetworkLayer) { resolver in
                let localService = resolver.resolve(
                    LocalDataStorage.self,
                    name: DIName.swiftDataStorage
                )!

                return GeneratedAPI(localStorage: localService)
            }
    }

    private func registerLocalStorage(container: Container) {
        container.register(
            LocalDataStorage.self,
            name: DIName.userDefaultsStorage)
        { _ in UserDefaultsStorage() }.inObjectScope(.container)

        container.register(
            LocalDataStorage.self,
            name: DIName.swiftDataStorage)
        { _ in SwiftDataStorage() }.inObjectScope(.container)
    }
}
