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
        self.actionsStorage.contextPublisher.sink { [weak self] _ in
            self?.presenter.displayActionsList(actions: self?.actionsStorage.getActionsList() ?? [])
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

    func addActionRepetition(action: CountableAction) {
        let currentRepeats = action.currentRepeats + 1 > action.maxRepeats ? 1 : action.currentRepeats + 1
        let newAction = CountableAction(id: action.id,
                                        title: action.title,
                                        maxRepeats: action.maxRepeats,
                                        currentRepeats: currentRepeats)
        Task {
            let result = await networkLayer.increaseActionCount(action: newAction)
            switch result {
            case .success(let action):
                actionsStorage.updateAction(action: action)
            case .failure(let error):
                if case .noInternet = error {
                    presenter.displayActionsList(actions: actionsStorage.getActionsList())
                }
            }
        }
    }
}
