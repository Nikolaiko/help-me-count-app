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

    func addActionRepetition(action: CountableAction) {
        let newAction = CountableAction(id: action.id,
                                        title: action.title,
                                        maxRepeats: action.maxRepeats,
                                        currentRepeats: action.currentRepeats + 1)
        Task {
            let result = await networkLayer.increaseActionCount(action: newAction)
            switch result {
            case .success(let actions):
                print("Success")
                //actionsStorage.refreshActions(actions: actions)
                //presenter.displayActionsList(actions: actions)
            case .failure(let error):
                print(error)
                if case .noInternet = error {
                    presenter.displayActionsList(actions: actionsStorage.getActionsList())
                }
            }
        }
    }
}
