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

        do {
            switch viewData.destination {
            case .authorized:
                try router?.navigateToAuthorized(parent: navParent)
            case .login:
                try router?.navigateToLogin(parent: navParent)
            }
        } catch _ as DIErrors {
            showDIError()
        } catch {
            showErrorAlert(title: "Неизвестаня ошибка")
        }
    }
}
