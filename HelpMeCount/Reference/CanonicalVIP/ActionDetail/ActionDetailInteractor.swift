//
//  ActionDetailInteractor.swift
//  HelpMeCount
//
//  DataStore.action заполняется НЕ здесь, а роутером сцены-источника через passData —
//  до того, как этот экран будет показан. Interactor лишь читает своё состояние на load().
//

import Foundation

protocol ActionDetailBusinessLogic {
    func load(request: ActionDetail.Load.Request)
}

protocol ActionDetailDataStore {
    var action: CountableAction? { get set }
}

final class ActionDetailInteractor: ActionDetailBusinessLogic, ActionDetailDataStore {
    var presenter: ActionDetailPresentationLogic?

    // MARK: - DataStore
    var action: CountableAction?

    // MARK: - BusinessLogic
    func load(request: ActionDetail.Load.Request) {
        presenter?.present(response: .init(action: action))
    }
}
