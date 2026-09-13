//
//  AddActionInteractor.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 18.02.2026.
//

import Foundation

protocol AddActionInteractor: PassDataStorage {
    func createNewAction()
    func updateActionName(request: UpdateActionName.Request)
    func updateMaxCount(request: UpdateMaxCount.Request)
    func updateCurrentCount(request: UpdateCurrentCount.Request)
}

protocol PassDataStorage {
    var passedDate: Date { get set }
}
