//
//  ActionsTabInteractor.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 15.03.2026.
//

import Foundation
import Combine

class ActionsTabInteractor: ActionsListInteractor {
    private let presenter: ActionsListPresenter
    private let worker: ListWorker
    private var disposeBag: Set<AnyCancellable> = []

    init(presenter: ActionsListPresenter, worker: ListWorker) {
        self.presenter = presenter
        self.worker = worker
    }

    func initSubscriptions() {
        self.worker.contextPublisher.sink { [weak self] _ in
            let actions = self?.worker.getActionsList() ?? []
            self?.presenter.displayActionsList(response: .init(actions: actions))
        }
        .store(in: &disposeBag)
    }

    func resfreshActionsList() {
        Task {
            let result = await worker.getActions()
            switch result {
            case .success(let actions):
                worker.refreshActions(actions: actions)
                presenter.displayActionsList(response: .init(actions: actions))
            case .failure(let error):
                if case .noInternet = error {
                    presenter.displayActionsList(response: .init(actions: worker.getActionsList()))
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
            let result = await worker.increaseActionCount(action: newAction)
            switch result {
            case .success(let action):
                worker.updateAction(action: action)
            case .failure(let error):
                if case .noInternet = error {
                    presenter.displayActionsList(response: .init(actions: worker.getActionsList()))
                }
            }
        }
    }
}
