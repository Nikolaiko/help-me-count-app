//
//  AppRootView.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 15.08.2026.
//

import Foundation

protocol AppRootView: NavigatableView {
    var interactor: AppRootInteractor? { get set }
    var router: AppRootRouter? { get set }

    func isUserLogged(viewData: CheckLoginStatus.ViewData)
}
