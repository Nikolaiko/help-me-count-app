//
//  AppRootConfigurator.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 27.12.2025.
//

import Foundation
import Swinject

struct AppRootConfigurator {
    private let resolver: Resolver

    init(resolver: Resolver) {
        self.resolver = resolver
    }

    func configure(view: AppRootViewController) throws {
        guard let presenter = resolver.resolve(AppRootPresenter.self, argument: view),
              let interactor = resolver.resolve(AppRootInteractor.self, argument: presenter),
              let router = resolver.resolve(AppRootRouter.self)
        else { throw DIError.unableToResolveDependency }

        view.interactor = interactor
        view.router = router
    }
}
