//
//  ActionsView.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 15.08.2026.
//

import Foundation

protocol ActionsView: AnyObject {
    var interactor: ActionsListInteractor? { get set }
    var router: MainFeatureRouter? { get set }

    func refreshActionsList(actions: [CountableAction])
}
