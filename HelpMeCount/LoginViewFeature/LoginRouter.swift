//
//  LoginRouter.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 11.11.2025.
//

import Foundation
import Swinject

struct LoginRouter {

    private let container: Container

    init(container: Container) {
        self.container = container
    }

    func navigateToActions() {
        guard let configurator = container.resolve(ActionsConfigurator.self) else { return }

        let actionsController = ActionsViewController()
        
    }
}
