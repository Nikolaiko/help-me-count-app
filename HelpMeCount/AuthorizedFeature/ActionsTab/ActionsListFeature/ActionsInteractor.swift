//
//  ActionsInteractor.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 28.12.2025.
//

import Foundation

class ActionsInteractor {
    private let presenter: ActionsPresenter
    private let networkService: NetworkService
    private let localStorage: LocalDataStorage

    init(presenter: ActionsPresenter,
         networkService: NetworkService,
         localStorage: LocalDataStorage) {

        self.presenter = presenter
        self.networkService = networkService
        self.localStorage = localStorage
        self.localStorage.delegate = self
    }

    func getAllActions() {
        Task {
            let actions = await networkService.getAllActions()
            presenter.updateActionsList(actions: actions)
        }
    }
}

extension ActionsInteractor: DBUpdateListener {
    func databaseUpdated() {        
        getAllActions()
    }
}
