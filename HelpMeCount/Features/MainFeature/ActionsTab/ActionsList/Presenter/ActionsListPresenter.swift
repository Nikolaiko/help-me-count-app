//
//  ActionsListPresenter.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 15.03.2026.
//

import Foundation

protocol ActionsListPresenter {
    func displayActionsList(response: RefreshActions.Response)
    func displayError(message: String)
}
