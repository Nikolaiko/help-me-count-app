//
//  ActionsConfigurator.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 13.11.2025.
//

import UIKit
import Swinject

struct ActionsConfigurator {

    private let resolver: Resolver
    private let parentController: UINavigationController

    init(resolver: Resolver, parentController: UINavigationController) {
        self.resolver = resolver
        self.parentController = parentController
    }

    public func configure(view: ActionsViewController) throws {
        guard let presenter = resolver.resolve(ActionsPresenter.self, argument: view),
              let interactor = resolver.resolve(ActionsInteractor.self, argument: presenter)
        else { throw DIError.unableToResolveDependency }

        view.interactor = interactor
    }
}
