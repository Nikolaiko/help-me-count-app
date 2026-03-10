//
//  AddActionInteractor.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 18.02.2026.
//

import Foundation

protocol AddActionInteractor {
    func createNewAction()
    func updateActionName(name: String)
    func updateMaxCount(count: Int?)
    func updateCurrentCount(count: Int?)
}
