//
//  ServicesAssembly.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 29.12.2025.
//

import Foundation
import Swinject

class ServicesAssembly: Assembly {
    func assemble(container: Swinject.Container) {
        container.register(LocalTokensStorage.self) { resolver in
            UserDefaultsStorage()
        }

        container.register(NetworkService.self, name: "always_login") { resolver in
            AlwaysLoginMock()
        }

        container.register(NetworkService.self, name: "always_fail_login") { resolver in
            AlwaysFailLoginMock()
        }

        container.register(NetworkService.self, name: "custom_api") { resolver in
            APILayer()
        }

        container.register(
            NetworkService.self,
            name: DINames.generatedAPI)
        { resolver in
            GeneratedAPI(
                localService: resolver.resolve(LocalTokensStorage.self)!
            )
        }.inObjectScope(.container)

        container.register(
            NetworkService.self,
            name: DINames.generatedLocalAPI)
        { resolver in
            GeneratedLocalAPI(
                localService: resolver.resolve(LocalTokensStorage.self)!
            )
        }.inObjectScope(.container)

        container.register(
            LocalActionsStorage.self
        ) { _ in
            SwiftDataStorage()
        }.inObjectScope(.container)
    }
}
