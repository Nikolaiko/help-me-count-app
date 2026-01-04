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
        container.register(NetworkService.self) { _ in AppNetworkService() }
    }
}
