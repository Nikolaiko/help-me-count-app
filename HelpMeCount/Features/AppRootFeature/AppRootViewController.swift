//
//  AppRootViewController.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 29.12.2025.
//

import UIKit

class AppRootViewController: BaseController, AppRootView {

    var interactor: AppRootInteractor?
    var router: AppRootRouter?

    override func viewDidLoad() {
        super.viewDidLoad()

        interactor?.checkLoginStatus()
    }

    func isUserLogged(viewData: CheckLoginStatus.ViewData) {
        guard let navParent = self.navigationController else { return }

        do {
            if viewData.isLogged {
                try router?.navigateToAuthorized(parent: navParent)
            } else {
                try router?.navigateToLogin(parent: navParent)
            }
        } catch _ as DIErrors {
            showDIError()
        } catch {
            showErrorAlert(title: "Неизвестаня ошибка")
        }
    }
}
