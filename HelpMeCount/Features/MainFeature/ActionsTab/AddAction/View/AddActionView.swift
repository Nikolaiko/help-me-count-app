//
//  AddActionView.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 15.08.2026.
//

import Foundation

protocol AddActionView: AnyObject {
    var interactor: AddActionInteractor? { get set }
    var router: MainFeatureRouter? { get set }

    func setAddButtonEnabled(enabled: Bool)
    func newActionAdded()
}
