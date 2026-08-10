//
//  ActionDetailPresenter.swift
//  HelpMeCount
//

import Foundation

protocol ActionDetailPresentationLogic {
    func present(response: ActionDetail.Load.Response)
}

final class ActionDetailPresenter: ActionDetailPresentationLogic {
    weak var viewController: ActionDetailDisplayLogic?

    func present(response: ActionDetail.Load.Response) {
        let action = response.action
        viewController?.display(viewModel: .init(
            title: action?.title ?? "—",
            progress: action.map { "\($0.currentRepeats) / \($0.maxRepeats)" } ?? "нет данных"
        ))
    }
}
