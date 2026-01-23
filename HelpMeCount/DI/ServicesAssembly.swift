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
        container.register(LocalDataStorage.self) { _ in UserDefaultsStorage() }

        registerNetworkLayer(container: container)
    }

    private func registerNetworkLayer(container: Container) {
        container.register(
            NetworkService.self,
            name: DIImplementationName.basicNetworkLayer)
        { _ in AppNetworkService() }

        container.register(
            NetworkService.self,
            name: DIImplementationName.generatedNetworkLayer)
        { _ in GeneratedAPI() }
    }
}
