//
//  LoginConfigurator.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 09.11.2025.
//

import Foundation
import Swinject

class LoginConfigurator {

    private let container: Container

    init(container: Container) {
        self.container = container
    }

    func configure(view: LoginViewController) {
        let presenter = LoginPresenter(view: view)
        let networkService = container.resolve(NetworkService.self)!
        let dbService = container.resolve(LocalDataStorage.self)!
        let interactor = LoginInteractor(presenter: presenter, networkService: networkService, storage: dbService)

        view.interactor = interactor
    }
}
