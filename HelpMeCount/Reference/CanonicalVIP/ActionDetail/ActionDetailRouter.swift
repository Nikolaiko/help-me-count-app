//
//  ActionDetailRouter.swift
//  HelpMeCount
//
//  dataStore здесь settable (DataPassing get set) — чтобы роутер источника мог
//  записать в него данные до показа экрана.
//

import UIKit

protocol ActionDetailRoutingLogic {
    func routeBack()
}

protocol ActionDetailDataPassing {
    var dataStore: ActionDetailDataStore? { get set }
}

final class ActionDetailRouter: ActionDetailRoutingLogic, ActionDetailDataPassing {
    weak var viewController: ActionDetailViewController?
    var dataStore: ActionDetailDataStore?

    func routeBack() {
        viewController?.navigationController?.popViewController(animated: true)
    }
}
