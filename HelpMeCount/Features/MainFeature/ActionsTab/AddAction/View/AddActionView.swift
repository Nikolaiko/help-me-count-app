//
//  AddActionView.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 15.08.2026.
//

import UIKit

protocol AddActionView: NavigatableView {
    var interactor: AddActionInteractor? { get set }
    var router: AddActionRouter? { get set }

    func setAddButtonEnabled(viewData: ValidateNewAction.ViewData)
    func newActionAdded()
}
