//
//  ActionsView.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 15.08.2026.
//

import UIKit

protocol ActionsView: NavigatableView {
    var interactor: ActionsListInteractor? { get set }
    var router: ActionsListRouter? { get set }

    func refreshActionsList(viewData: RefreshActions.ViewData)
}
