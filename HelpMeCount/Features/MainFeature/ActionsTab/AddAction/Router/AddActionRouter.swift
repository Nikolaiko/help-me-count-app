//
//  AddActionRouter.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 26.01.2026.
//

import UIKit

protocol AddActionRoutingLogic {
    func routeBackFromAddAction()
}

protocol AddActionDataPassing {
    var dataStore: AddActionDataStore? { get }
}

protocol AddActionDataStore {
    // Пока сцены не делятся данными напрямую — слот на будущее.
}

class AddActionRouter: AddActionRoutingLogic, AddActionDataPassing {

    weak var viewController: AddActionViewController?
    var dataStore: AddActionDataStore?

    private let services: AppServices

    init(services: AppServices) {
        self.services = services
    }

    func routeBackFromAddAction() {
        guard let source = viewController else { return }

        source.navigationController?.popViewController(animated: true)
    }
}
