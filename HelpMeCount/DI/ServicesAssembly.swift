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
        container.register(LocalStorageService.self, name: "always_not_logged") { resolver in
            AlwaysNotLoggedService()
        }

        container.register(LocalStorageService.self, name: "always_logged") { resolver in
            AlwaysLoggedInService()
        }

        container.register(NetworkService.self, name: "always_login") { resolver in
            AlwaysLoginMock()
        }

        container.register(NetworkService.self, name: "always_fail_login") { resolver in
            AlwaysFailLoginMock()
        }
    }
}
