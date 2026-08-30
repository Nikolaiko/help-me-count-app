//
//  AppRootViewController.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 29.12.2025.
//

import UIKit

class AppRootViewController: BaseController, AppRootDisplayLogic {

    var interactor: AppRootInteractor?
    var router: AppRootRouter?

    override func viewDidLoad() {
        super.viewDidLoad()

        interactor?.checkLoginStatus(request: AppRoot.CheckLoginStatus.Request())
    }

    func displayLoginStatus(viewData: AppRoot.CheckLoginStatus.ViewData) {
        guard let navParent = self.navigationController else { return }

        switch viewData.destination {
        case .authorized:
            router?.routeToAuthorized(parent: navParent)
        case .login:
            router?.routeToLogin(parent: navParent)
        }
    }
}
