//
//  ActionsBoardInteractor.swift
//  HelpMeCount
//
//  Каноничный CS: Interactor реализует ДВА протокола —
//  BusinessLogic (что он умеет делать) и DataStore (какое состояние сцены хранит).
//  Именно DataStore потом читает Router при переходе.
//

import Foundation

protocol ActionsBoardBusinessLogic {
    func loadActions(request: ActionsBoard.Load.Request)
    func selectAction(request: ActionsBoard.Select.Request)
}

protocol ActionsBoardDataStore {
    var actions: [CountableAction] { get set }
    var selectedAction: CountableAction? { get set }
}

final class ActionsBoardInteractor: ActionsBoardBusinessLogic, ActionsBoardDataStore {
    var presenter: ActionsBoardPresentationLogic?

    // MARK: - DataStore (состояние сцены)
    var actions: [CountableAction] = []
    var selectedAction: CountableAction?

    // MARK: - BusinessLogic
    func loadActions(request: ActionsBoard.Load.Request) {
        // В реальном коде — через Worker/Service. Здесь демо-данные.
        actions = [
            CountableAction(id: UUID(), title: "Отжимания", maxRepeats: 100, currentRepeats: 40),
            CountableAction(id: UUID(), title: "Приседания", maxRepeats: 200, currentRepeats: 120)
        ]
        presenter?.presentActions(response: .init(actions: actions))
    }

    func selectAction(request: ActionsBoard.Select.Request) {
        guard actions.indices.contains(request.index) else { return }
        // Кладём выбор в DataStore — а НЕ передаём его напрямую в роутер.
        selectedAction = actions[request.index]
    }
}
