//
//  ActionsTabInteractor.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 15.03.2026.
//

import Foundation
import Combine

class ActionsTabInteractor: ActionsListInteractor {
    private let networkLayer: NetworkService
    private let presenter: ActionsListPresenter
    private let actionsStorage: LocalActionsStorage
    private var disposeBag: Set<AnyCancellable> = []

    init(networkLayer: NetworkService, presenter: ActionsListPresenter, actionsStorage: LocalActionsStorage) {
        self.networkLayer = networkLayer
        self.presenter = presenter
        self.actionsStorage = actionsStorage
    }

    func initSubscriptions() {
        print("initSubscriptions")
        self.actionsStorage.contextPublisher.sink { [weak self] _ in
            self?.resfreshActionsList()
        }
        .store(in: &disposeBag)
    }

    func resfreshActionsList() {
        Task {
            let result = await networkLayer.getActions()
            switch result {
            case .success(let actions):
                actionsStorage.refreshActions(actions: actions)
                presenter.displayActionsList(actions: actions)
            case .failure(let error):
                if case .noInternet = error {
                    presenter.displayActionsList(actions: actionsStorage.getActionsList())
                }
            }
        }
    }
}
