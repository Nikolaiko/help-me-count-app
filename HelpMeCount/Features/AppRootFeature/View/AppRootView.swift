//
//  AppRootView.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 15.08.2026.
//

import Foundation

protocol AppRootView: AnyObject {
    var interactor: AppRootInteractor? { get set }
    var router: AppRootRouter? { get set }

    func isUserLogged(isLogged: Bool)
}
