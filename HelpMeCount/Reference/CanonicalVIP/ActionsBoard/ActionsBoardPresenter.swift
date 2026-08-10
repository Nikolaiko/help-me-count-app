//
//  ActionsBoardPresenter.swift
//  HelpMeCount
//

import Foundation

protocol ActionsBoardPresentationLogic {
    func presentActions(response: ActionsBoard.Load.Response)
}

final class ActionsBoardPresenter: ActionsBoardPresentationLogic {
    weak var viewController: ActionsBoardDisplayLogic?

    func presentActions(response: ActionsBoard.Load.Response) {
        let rows = response.actions.map { action in
            ActionsBoard.Load.ViewModel.Row(
                title: action.title,
                progress: "\(action.currentRepeats) / \(action.maxRepeats)"
            )
        }
        viewController?.displayActions(viewModel: .init(rows: rows))
    }
}
