//
//  ActionsTabInteractor.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 15.03.2026.
//

import Foundation
import Combine

class ActionsTabInteractor: ActionsListInteractor, ActionsDataStore {
    private let presenter: ActionsListPresenter
    private let worker: ActionsWorker
    private var disposeBag: Set<AnyCancellable> = []

    init(presenter: ActionsListPresenter, worker: ActionsWorker) {
        self.presenter = presenter
        self.worker = worker
    }

    func initSubscriptions() {
        worker.changesPublisher.sink { [weak self] _ in
            self?.presenter.displayActionsList(actions: self?.worker.cachedActions() ?? [])
        }
        .store(in: &disposeBag)
    }

    func resfreshActionsList() {
        Task {
            let result = await worker.fetchActions()
            switch result {
            case .success(let actions):
                worker.cacheActions(actions)
                presenter.displayActionsList(actions: actions)
            case .failure(let error):
                if case .noInternet = error {
                    presenter.displayActionsList(actions: worker.cachedActions())
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
            let result = await worker.increaseCount(action: newAction)
            switch result {
            case .success(let action):
                worker.update(action: action)
            case .failure(let error):
                if case .noInternet = error {
                    presenter.displayActionsList(actions: worker.cachedActions())
                }
            }
        }
    }
}
