//
//  MainFeatureConfigurator.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 07.01.2026.
//

import Foundation
import Swinject

class MainFeatureConfigurator {
    private let resolver: Resolver

    init(resolver: Resolver) {
        self.resolver = resolver
    }

    func configure(view: MainViewController) throws {

        
    }

    func configure(view: ActionsViewController) throws {
        guard let router = resolver.resolve(MainFeatureRouter.self)
        else { throw DIErrors.unableToResolve }

        view.router = router
    }

    func configure(view: AddActionViewController) throws {
        guard let presenter = resolver.resolve(AddActionPresenter.self, argument: view),
              let interactor = resolver.resolve(AddActionInteractor.self, argument: presenter)
        else { throw DIErrors.unableToResolve }

        view.interactor = interactor
    }
}
