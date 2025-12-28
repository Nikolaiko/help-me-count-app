//
//  ActionsConfigurator.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 13.11.2025.
//

import Foundation
import Swinject

struct ActionsConfigurator {

    private let resolver: Resolver

    init(resolver: Resolver) {
        self.resolver = resolver
    }

    public func configure(view: ActionsViewController) throws {
        guard let interactor = resolver.resolve(ActionsInteractor.self)
        else { throw DIError.unableToResolveDependency }

        view.interactor = interactor
    }
}
